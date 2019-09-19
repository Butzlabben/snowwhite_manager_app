import 'package:flutter/material.dart';
import 'package:snowwhite_manager/screens/scan_ticket.dart';
import 'package:snowwhite_manager/screens/ticket_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  Widget body = TicketList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Snowwhite Manager', style: TextStyle(color: Colors.white)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), title: Text("Tickets")),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), title: Text("Scannen")),
        ],
        currentIndex: _index,
        onTap: onNavigate,
      ),
      floatingActionButton: _index == 0
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => Navigator.pushNamed(context, '/addTicket'),
            )
          : Container(),
      body: body,
    );
  }

  onNavigate(int index) {
    setState(() {
      _index = index;
      if(_index == 0)
        body = TicketList();
      if(_index == 1)
        body = ScanTicket();
    });
  }
}
