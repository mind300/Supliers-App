import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
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
    this.onEdit,
    this.onChanged,
    this.autoValidateMode,
    this.textInputAction,
  });

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
  final void Function(String?)? onSaved, onEdit, onChanged;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode? autoValidateMode;
  final TextInputAction? textInputAction;
  final bool readOnly;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool isPasswordVisible;

  @override
  void initState() {
    super.initState();
    isPasswordVisible = !widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final bool isPasswordField = widget.obscureText;

    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when tapping outside
        FocusScope.of(context).unfocus();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Tooltip(
                message: widget.toolTipMessage ?? '',
                child: Row(
                  children: [
                    Text(
                      widget.title!,
                      style: TextStyle(
                        fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (widget.toolTipMessage != null)
                      Tooltip(
                        message: widget.toolTipMessage!,
                        triggerMode: TooltipTriggerMode.tap,
                        showDuration: const Duration(seconds: 3),
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
            enabled: widget.enabled,
            controller: widget.controller,
            autofocus: false,
            obscureText: isPasswordField && !isPasswordVisible,
            onSaved: widget.onSaved,
            onEditingComplete: () {
              widget.onEdit!(widget.controller!.text);
              FocusScope.of(context).unfocus(); // Dismiss keyboard on editing complete
            },
            onFieldSubmitted: (value) {
              FocusScope.of(context).unfocus(); // Dismiss keyboard on field submission
            },
            onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
            onChanged: widget.onChanged,
            inputFormatters: widget.inputFormatters,
            readOnly: widget.readOnly,
            validator: widget.validator ??
                (v) {
                  if (v!.isEmpty) {
                    return 'هذا الحقل مطلوب';
                  }
                  return null;
                },
            keyboardType: widget.textInputType,
            maxLines: widget.maxLines!.toInt(),
            style: TextStyle(
              color: const Color(0xFF1D1D1D),
              fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              suffixIcon: isPasswordField
                  ? IconButton(
                      icon: Icon(
                        !isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    )
                  : widget.suffixIcon,
              prefixIcon: widget.prefixIcon,
              hintStyle: TextStyle(
                color: AppColors.black.withOpacity(0.3),
                fontSize: 14.sp,
                fontWeight: FontWeight.w300,
              ),
              hintText: widget.hintText,
              filled: true,
              fillColor: widget.fillColor,
              border: buildBorder(),
              enabledBorder: buildBorder(),
              focusedBorder: buildBorder(),
            ),
            autovalidateMode: widget.autoValidateMode,
            textInputAction: widget.textInputAction,
          ),
        ],
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius!),
      borderSide: BorderSide(
        width: 1,
        color: AppColors.textfieldBorderColor,
      ),
    );
  }
}
