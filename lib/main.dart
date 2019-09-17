import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:snowwhite_manager/add_ticket.dart';
import 'package:snowwhite_manager/button.dart';
import 'package:snowwhite_manager/home.dart';
import 'package:snowwhite_manager/scan_ticket.dart';
import 'package:snowwhite_manager/verify.dart';

void main() => runApp(SnowwhiteManager());

class SnowwhiteManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snowwhite Manager',
      theme: ThemeData(
        primaryColor: Colors.lightBlue,
      ),
      routes: {
        '/': (context) => MainScreen(),
        '/addTicket': (context) => AddTicket(),
        '/scanTicket': (context) => ScanTicket(),
        '/verify': (context) => VerifyPin(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _loggedIn;
  final key = GlobalKey<FormState>();
  String name, pin;

  @override
  Widget build(BuildContext context) {
    checkUser();
    if (_loggedIn == null) return Container();

    if (_loggedIn) {
      return HomeScreen();
    } else {
      return Form(
        key: key,
        child: new Scaffold(
          appBar: AppBar(title: Text('Einloggen')),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    validator: (val) =>
                        val.isEmpty ? 'Bitte gebe deinen Nachnamen an' : null,
                    onSaved: (val) => name = val,
                    decoration: InputDecoration(labelText: 'Nachname'),
                  ),
                  TextFormField(
                    validator: (val) =>
                        val.isEmpty ? 'Bitte gebe deine PIN an' : null,
                    onSaved: (val) => pin = val,
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'PIN'),
                    keyboardType: TextInputType.number,
                  ),
                  Center(
                      child: Button.text(
                    text: "Einloggen",
                    onTap: logIn,
                  )),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  logIn() async {

  }

  checkUser() async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    String token = await storage.read(key: 'token');
    setState(() {
      _loggedIn = token != null;
    });
  }
}
