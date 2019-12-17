import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snowwhite_manager/api.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  StreamController<DashboardInfo> _controller;

  @override
  void initState() {
    _controller = StreamController.broadcast();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DashboardInfo>(
      stream: _controller.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();
        DashboardInfo info = snapshot.data;
        return ListView(
          padding: EdgeInsets.all(8),
          children: <Widget>[
            ListTile(
              title: Text('Tickets insgesamt verkauft:'),
              trailing: Text('${info.ticketsSold}'),
            ),
            ListTile(
              title: Text('Tickets benutzt:'),
              trailing: Text('${info.ticketsUsed}'),
            ),
            ListTile(
              title: Text('Tickets verkauft (in Prozent):'),
              trailing: Text('${info.ticketsUsedPercent}'),
            ),
            SizedBox(height: 16),
            Text(
              'Tickets verkauft pro VerkäuferIn',
              textAlign: TextAlign.center,
            ),
            ...info.ticketsSoldByPerson.entries.map(
              (entry) {
                return ListTile(
                  title: Text(entry.key),
                  trailing: Text(
                    entry.value.toString(),
                  ),
                );
              },
            ).toList()
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
