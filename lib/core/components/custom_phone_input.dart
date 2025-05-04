import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:supplies/core/constant/app_colors.dart';

class CustomPhoneInput extends StatelessWidget {
  const CustomPhoneInput({
    super.key,
    this.title,
    this.toolTipMessage,
    this.controller,
    this.validator,
    this.autoValidateMode,
    this.onChanged,
    this.enabled = true,
    this.fillColor = AppColors.textfieldColor,
    this.borderRadius = 10,
    this.initialCountryCode = 'EG',
  });

  final String? title;
  final String? toolTipMessage;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final AutovalidateMode? autoValidateMode;
  final void Function(String)? onChanged;
  final bool enabled;
  final Color fillColor;
  final double borderRadius;
  final String initialCountryCode;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: AppColors.black.withOpacity(0.3),
      fontSize: 12.sp,
      fontWeight: FontWeight.w300,
    );

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
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  if (toolTipMessage != null)
                    Tooltip(
                      message: toolTipMessage ?? "",
                      triggerMode: TooltipTriggerMode.tap,
                      showDuration: Duration(seconds: toolTipMessage != null ? 3 : 0),
                      child: Icon(
                        Icons.help_outline_outlined,
                        size: 14.sp,
                      ),
                    )
                ],
              ),
            ),
          ),
        IntlPhoneField(
          enabled: enabled,
          controller: controller,
          initialCountryCode: initialCountryCode,
          autovalidateMode: autoValidateMode ?? AutovalidateMode.onUserInteraction,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          validator: (phone) {
            final val = phone?.number;
            if (validator != null) return validator!(val);
            if (val == null || val.isEmpty) return 'هذا الحقل مطلوب';
            return null;
          },
          decoration: InputDecoration(
            hintText: "Mobile Number",
            hintStyle: textStyle,
            filled: true,
            fillColor: fillColor,
            border: buildBorder(),
            enabledBorder: buildBorder(),
            focusedBorder: buildBorder(),
            errorBorder: buildBorder(color: Colors.red),
            focusedErrorBorder: buildBorder(color: Colors.red),
          ),
          onChanged: (phone) => onChanged?.call(phone.completeNumber),
        ),
      ],
    );
  }

  OutlineInputBorder buildBorder({Color? color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(
        width: 1.3,
        color: color ?? AppColors.textfieldBorderColor,
      ),
    );
  }
}
