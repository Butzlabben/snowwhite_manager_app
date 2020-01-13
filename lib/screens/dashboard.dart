import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snowwhite_manager/api.dart';

extension Precision on double {
  double toPrecision(int fractionDigits) {
    double mod = pow(10, fractionDigits.toDouble());
    return ((this * mod).round().toDouble() / mod);
  }
}

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        setState(() {
        });
        return Future.value();
      },
      child: FutureBuilder<DashboardInfo>(
        future: getInfo(),
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
                title: Text('Tickets benutzt (in Prozent):'),
                trailing: Text('${info.ticketsUsedPercent.toPrecision(2)}%'),
              ),
              SizedBox(height: 24),
              Text(
                'Tickets verkauft pro VerkäuferIn',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
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
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
