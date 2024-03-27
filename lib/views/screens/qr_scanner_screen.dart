import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanController extends GetxController {
  var qrData = Rx<String?>(null);
  final qrKey = GlobalKey(debugLabel: 'QR');

  void onQRViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen((scanData) {
      if (scanData != null) {
        qrData.value = scanData.code ?? '';
      }
    });
  }
}

class QRScanScreen extends StatelessWidget {
  final QRScanController qrScanController = Get.put(QRScanController());

  QRScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scan Screen'),
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            bottom: 70,
            child: QRView(
              key: qrScanController.qrKey,
              onQRViewCreated: qrScanController.onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.white,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 70,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(
                    () => Text('QR Data: ${qrScanController.qrData.value}',
                        textAlign: TextAlign.center),
                  ),
                  const Icon(Icons.qr_code_scanner, size: 30),
                  const Text('Đang quét mã QR...'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
