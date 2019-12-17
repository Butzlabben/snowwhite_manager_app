import 'package:flutter/material.dart';
import 'package:snowwhite_manager/api.dart';

class TicketList extends StatefulWidget {
  @override
  _TicketListState createState() => _TicketListState();
}

class _TicketListState extends State<TicketList> {
  List<Ticket> tickets = [];
  bool reachedEnd = false;

  @override
  Widget build(BuildContext context) {
    fetchFirst();
    return RefreshIndicator(
      onRefresh: () {
        tickets = [];
        return fetchFirst();
      },
      child: ListView.builder(
        itemBuilder: (context, i) {
          int length = tickets.length;
          if (i >= length) {
            tryFetchNext();
            return Container();
          }
          return TicketWidget(ticket: tickets[i]);
        },
        itemCount: tickets.isNotEmpty ? tickets.length + 1 : 0,
        cacheExtent: 500,
      ),
    );
  }

  fetchFirst() async {
    if (this.tickets.length != 0) return;
    List<Ticket> tickets = await listTickets();
    if (mounted)
      setState(() {
        this.tickets = tickets;
        reachedEnd = false;
      });
  }

  tryFetchNext() async {
    if (reachedEnd) return;
    List<Ticket> tickets = await listTickets(offset: this.tickets.length);
    if (tickets.length == 0) {
      reachedEnd = true;
      return;
    }
    if (mounted)
      setState(() {
        this.tickets.addAll(tickets);
      });
  }
}

class TicketWidget extends StatelessWidget {
  final Ticket ticket;

  const TicketWidget({Key key, this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String time = ticket.created.toString();
    time = time.substring(0, time.length - 7);
    return ListTile(
        title: Text(
          ticket.name,
          style: ticket.used ? TextStyle(color: Color(0xFFFF0000), decoration: TextDecoration.lineThrough) : TextStyle(),
        ),
        subtitle: Text(ticket.number),
        trailing: Text(time));
  }
}
