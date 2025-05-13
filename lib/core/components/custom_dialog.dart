import 'package:flutter/material.dart';
import 'package:supplies/core/constant/app_colors.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    this.title,
    this.content,
    this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.onCancel,
    this.isError,
    this.isSuccess,
  });

  final String? title;
  final String? content;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool? isError;
  final bool? isSuccess;

  @override
  Widget build(BuildContext context) {
    Icon? dialogIcon;

    if (isError == true) {
      dialogIcon = const Icon(Icons.error_outline, color: Colors.red, size: 40);
    } else if (isSuccess == true) {
      dialogIcon = const Icon(Icons.check_circle_outline, color: Colors.green, size: 40);
    }

    return AlertDialog.adaptive(
      icon: dialogIcon,
      title: Text(title ??
          (isError == true
              ? 'Error'
              : isSuccess == true
                  ? 'Success'
                  : '')),
      content: Text(content ??
          (isError == true
              ? 'Something went wrong.'
              : isSuccess == true
                  ? 'Operation successful.'
                  : '')),
      actions: [
        TextButton(
          onPressed: onCancel ?? () => Navigator.of(context).pop(),
          child: Text(
            cancelText ?? 'Cancel',
            style: TextStyle(
              color: AppColors.dividerColor,
            ),
          ),
        ),
        TextButton(
          onPressed: onConfirm ?? () => Navigator.of(context).pop(),
          child: Text(
            confirmText ?? 'Confirm',
            style: TextStyle(
              color: AppColors.red,
            ),
          ),
        ),
      ],
    );
  }
}
