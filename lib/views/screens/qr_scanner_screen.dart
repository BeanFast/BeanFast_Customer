import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QRScannerScreen extends StatelessWidget {
  QRScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scanner Screen'),
      ),
      body: const Column(
        children: [const Text('QR Scanner Screen')],
      ),
    );
  }
}
