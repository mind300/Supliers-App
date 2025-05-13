import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:supplies/core/helpers/extensitions.dart';
import 'package:supplies/core/routes/routes.dart';
import 'package:supplies/core/widgets/drawer.dart';
import 'package:supplies/feature/qr_feature/controller/qr_cubit.dart';

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
        onDetect: (barcodeCapture) async {
          controller.stop();
          final barcode = await barcodeCapture.barcodes.first;
          final String? code = await barcode.rawValue;
          debugPrint('Scanned code: $code');

          if (code != null) {
            var res = await context.pushNamed(Routes.scanDetails, arguments: code);
          }
          controller.start();
          context.read<QrCubit>().reset();
        },
      ),
    );
  }
}
