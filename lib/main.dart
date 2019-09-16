import 'package:flutter/material.dart';
import 'package:snowwhite_manager/add_ticket.dart';
import 'package:snowwhite_manager/scan_ticket.dart';
import 'package:snowwhite_manager/verify.dart';

void main() => runApp(SnowwhiteManager());

class SnowwhiteManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snowwhite Manager',
      theme: ThemeData(
        primarySwatch: Colors.red,

      ),
      routes: {
        '/': (context) => HomeScreen(),
        '/addTicket': (context) => AddTicket(),
        '/scanTicket': (context) => ScanTicket(),
        '/verify': (context) => VerifyPin(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Snowwhite Manager'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () => Navigator.pushNamed(context, '/scanTicket'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, '/addTicket'),
      ),
      body: StreamBuilder(),
    );
  }
}
