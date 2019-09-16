import 'package:flutter/material.dart';

class VerifyPin extends StatefulWidget {
  @override
  _VerifyPinState createState() => _VerifyPinState();
}

class _VerifyPinState extends State<VerifyPin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextField(
          obscureText: true,
          keyboardType: TextInputType.number,

          onChanged: (val) {
            if(val.length == 4) {
              verify(val);
            }
            if(val.length > 4) {
              val = '';
            }
          },
        ),
      ),
    );
  }

  verify(String pin) {
    Navigator.pop(context, {});
  }
}
