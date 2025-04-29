import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:supplies/core/helpers.dart/extensitions.dart';
import 'package:supplies/core/routes/routes.dart';
import 'package:supplies/core/widgets/drawer.dart';

class QrScreen extends StatelessWidget {
  QrScreen({super.key});

  final MobileScannerController controller = MobileScannerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(currentPage: 'QR Scan'),
      appBar: AppBar(
        title: const Text('QR Code'),
      ),
      body: MobileScanner(
        controller: controller,
        onDetect: (barcodeCapture) {
          final barcode = barcodeCapture.barcodes.first;
          final String? code = barcode.rawValue;
          debugPrint('Scanned code: $code');

          if (code != null) {
            context.pushNamed(Routes.scanDetails);
          }
        },
      ),
    );
  }
}
