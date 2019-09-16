import 'package:flutter/material.dart';

class AddTicket extends StatefulWidget {
  @override
  _AddTicketState createState() => _AddTicketState();
}

class _AddTicketState extends State<AddTicket> {
  final key = GlobalKey<FormState>();
  String name, number;
  int amount;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Ticket hinzufügen'),
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(height: 64),
            TextFormField(
              onSaved: (val) => name = val.trim(),
              validator: (val) =>
                  val.isEmpty ? 'Bitte gebe einen Namen an' : null,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              onSaved: (val) => amount = int.parse(val.trim()),
              validator: (val) => int.tryParse(val.trim()) == null
                  ? 'Bitte gebe eine gültige Zahl an'
                  : null,
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              onSaved: (val) => number = val,
              validator: (val) =>
                  number.isEmpty ? 'Bitte gebe eine Telefonnummer an' : null,
              keyboardType: TextInputType.phone,
            ),
            Center(
              child: RaisedButton(
                onPressed: () => addTicket(),
                child: Text('Ticket hinzufügen'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  addTicket() async {
    FormState state = key.currentState;
    if (!state.validate()) return;
    state.save();

    Map<String, dynamic> result = await Navigator.pushNamed(context, '/verify');
    if (result == null) return;
    if (result['verified']) {
      var pin = result['pin'];
      // TODO save to database
    }
  }
}
