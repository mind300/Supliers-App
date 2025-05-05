import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:supplies/main.dart';

startLoading(BuildContext context) {
  return showDialog(
    context: navigatorKey.currentContext!,
    builder: (_) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}

stopLoading(BuildContext context) {
  Navigator.of(context).pop();
}
