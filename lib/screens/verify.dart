import 'package:flutter/material.dart';
import 'package:snowwhite_manager/api.dart' as prefix0;

class VerifyPin extends StatefulWidget {
  @override
  _VerifyPinState createState() => _VerifyPinState();
}

class _VerifyPinState extends State<VerifyPin> {
  TextEditingController _controller;
  bool falsePin = false;

  @override
  void initState() {
    _controller = TextEditingController();
    _controller.addListener(() {
      String text = _controller.text;
      if (text.length == 4) {
        verify(text);
      }
      if (text.length > 4) {
        _controller.clear();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PIN eingeben", style: TextStyle(color: Colors.white)),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: TextField(
            obscureText: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'PIN',
              border: OutlineInputBorder(borderSide: BorderSide()),
            ),
            controller: _controller,
            autofocus: true,
          ),
        ),
      ),
    );
  }

  verify(String pin) async {
    pin = pin.trim();
    bool verified = await prefix0.verify(pin);
    _controller.clear();
    if (!verified) {
      setState(() {
        falsePin = true;
      });
    } else {
      Navigator.pop(context, {'pin': pin});
    }
  }
}
