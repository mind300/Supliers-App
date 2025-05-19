import 'package:flutter/material.dart';
import 'package:supplies/main.dart';

startLoading(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: navigatorKey.currentContext!,
    builder: (_) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}

stopLoading(BuildContext context) {
  if (Navigator.canPop(context)) {
    Navigator.of(context).pop();
  }
}
