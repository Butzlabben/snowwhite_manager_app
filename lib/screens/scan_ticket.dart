import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:snowwhite_manager/api.dart';
import 'package:snowwhite_manager/button.dart';

typedef ScanCallback = void Function(String tid);

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
      child: result == null
          ? InputWidget(
              scanCallback: fetch,
            )
          : ResultWidget(
              result: result,
              exit: () {
                setState(
                  () {
                    result = null;
                  },
                );
              },
            ),
    );
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

class InputWidget extends StatefulWidget {
  final ScanCallback scanCallback;

  const InputWidget({Key key, this.scanCallback}) : super(key: key);

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController controller;
  TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: FloatingActionButton(
                  onPressed: () => controller.toggleFlash(),
                  child: Icon(Icons.flash_on),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 16),
        TextField(
            controller: textController,
            decoration: InputDecoration(labelText: 'Ticket ID')),
        Button.text(
          text: 'Manuell eingeben',
          onTap: () {
            widget.scanCallback(textController.text);
          },
        ),
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      print("==================================================");
      print(scanData);
      widget.scanCallback(scanData);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    textController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    textController = TextEditingController();
    super.initState();
  }
}

class ResultWidget extends StatelessWidget {
  final Scan result;
  final VoidCallback exit;

  const ResultWidget({Key key, this.result, this.exit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (result == null) return Container();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(result.icon, size: 58, color: result.color),
        SizedBox(height: 16,),
        Text(
          result.message,
          style: TextStyle(color: result.color, fontSize: 32),
        ),
        Button.text(
          text: "Weiter Scannen",
          onTap: exit,
        )
      ],
    );
  }
}
