import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class QRScanScreen extends StatefulWidget {
  @override
  _QRScanScreenState createState() => _QRScanScreenState();
}

class _QRScanScreenState extends State<QRScanScreen> {
  String qrCodeResult = "Chưa quét mã QR";

  Future<void> scanQR() async {
        var status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
    }
    try {
      var result = await BarcodeScanner.scan();
      setState(() {
        qrCodeResult = result.rawContent;
      });
    } catch (e) {
      setState(() {
        qrCodeResult = "Lỗi khi quét mã QR: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quét mã QR'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              qrCodeResult,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                scanQR();
              },
              child: Text('Quét mã QR'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> scanQR() async {
  try {
    var result = await BarcodeScanner.scan();
    if (result.type == ResultType.Barcode) {
      // Xử lý mã QR được quét ở đây
      print(result.rawContent);
    }
  } catch (e) {
    // Xử lý lỗi nếu có
    print('Error scanning QR code: $e');
  }
}
