import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/constant/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.hintText,
      this.textInputType,
      this.suffixIcon,
      this.prefixIcon,
      this.title,
      this.toolTipMessage,
      this.controller,
      this.enabled,
      this.onSaved,
      this.obscureText = false,
      this.validator,
      this.borderRadius = 10,
      this.inputFormatters,
      this.maxLines = 1,
      this.readOnly = false,
      this.fillColor = AppColors.textfieldColor,
      this.onChanged,
      this.autoValidateMode,
      this.textInputAction});
  final String hintText;
  final String? title;
  final String? toolTipMessage;
  final TextInputType? textInputType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? borderRadius;
  final double? maxLines;
  final bool? enabled;
  final Color fillColor;
  final void Function(String?)? onSaved, onChanged;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode? autoValidateMode;
  final TextInputAction? textInputAction;
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Tooltip(
              message: toolTipMessage ?? '',
              child: Row(
                spacing: 5.w,
                children: [
                  Text(
                    title!,
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleSmall!.fontSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (toolTipMessage != null)
                    Tooltip(
                      message: toolTipMessage ?? "",
                      triggerMode: TooltipTriggerMode.tap,
                      showDuration:
                          Duration(seconds: toolTipMessage != null ? 3 : 0),
                      child: Icon(
                        Icons.help_outline_outlined,
                        size: 14.sp,
                      ),
                    )
                ],
              ),
            ),
          ),
        TextFormField(
          textAlign: TextAlign.start,
          enabled: enabled,
          controller: controller,
          obscureText: obscureText,
          onSaved: onSaved,
          onChanged: onChanged,
          inputFormatters: inputFormatters,
          readOnly: readOnly,
          validator: validator ??
              (v) {
                if (v!.isEmpty) {
                  return 'هذا الحقل مطلوب';
                }
                return null;
              },
          keyboardType: textInputType,
          maxLines: maxLines!.toInt(),
          style: TextStyle(
            color: const Color(0xFF1D1D1D),
            fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            hintStyle: TextStyle(
              color: AppColors.black.withOpacity(0.3),
              fontSize: 12.sp,
              fontWeight: FontWeight.w300,
            ),
            hintText: hintText,
            filled: true,
            fillColor: fillColor,
            border: buildBorder(),
            enabledBorder: buildBorder(),
            focusedBorder: buildBorder(),
          ),
          autovalidateMode: autoValidateMode,
          textInputAction: textInputAction,
        ),
      ],
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius!),
      borderSide: BorderSide(
        width: 1,
        color: AppColors.textfieldBorderColor,
      ),
    );
  }
}
