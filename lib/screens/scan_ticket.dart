import 'package:flutter/material.dart';
import 'package:snowwhite_manager/api.dart';
import 'package:snowwhite_manager/button.dart';
import 'package:barcode_scan/barcode_scan.dart';

class ScanTicket extends StatefulWidget {
  @override
  _ScanTicketState createState() => _ScanTicketState();
}

class _ScanTicketState extends State<ScanTicket> {
  Scan result;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (result != null)
              Text(
                result.message,
                style: TextStyle(fontSize: 24, color: result.color),
              ),
            Button.text(text: "Scannen", onTap: onScan),
          ],
        ),
      ),
    );
  }

  onScan() async {
    // TODO scan
    String tid;
  }

  fetch(String tid) {
    Future<Scan> result = checkTicket(tid);
    result.then((val) {
      setState(() {
        this.result = val;
      });
    }).catchError((_) {
      setState(() {
        this.result = Scan(ScanResult.error);
      });
    });
  }
}

class ResultWidget extends StatelessWidget {
  final ScanResult result;

  const ResultWidget({Key key, this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (result == null) return Container();
  }
}
