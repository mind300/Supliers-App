import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

startLoading(BuildContext context) {
  return showDialog(
    context: context,
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
