import 'dart:async';

import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: QRApp(),
));

class QRApp extends StatefulWidget {
  @override
  QRAppState createState() {
    return new QRAppState();
  }
}

class QRAppState extends State<QRApp> {
  String result = "Scan QR Code Or BAR Code And Get Result Here !";

  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult;
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Scanner"),
      ),
      body: Center(

        child:  Container(
          // padding: EdgeInsets.all(50),
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 30.0,left:30.0,right: 30.0),
          child:
          SelectableText(result+"\n\n\n"+"Select Above Result And copy",
            cursorColor: Colors.red,

            showCursor: true,
            style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            toolbarOptions: ToolbarOptions(
                copy: true,
                selectAll: true,
                cut: false,
                paste: false
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        label: Text("Scan"),
        onPressed: _scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}