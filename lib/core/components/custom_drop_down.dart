import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/constant/app_colors.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? value;
  final String? hintText;
  final void Function(T?) onChanged;
  final String Function(T)? itemLabelBuilder;
  final String? errorText;
  final String? title;

  const CustomDropdown({
    Key? key,
    required this.items,
    required this.onChanged,
    this.value,
    this.hintText,
    this.itemLabelBuilder,
    this.errorText,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              title!,
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        DropdownButtonFormField<T>(
          value: value,
          hint: Text(
            hintText ?? '',
            style: TextStyle(
              color: AppColors.black.withOpacity(0.3),
              fontSize: 12.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
          dropdownColor: AppColors.white,
          decoration: InputDecoration(
            fillColor: AppColors.textfieldColor,
            filled: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            border: buildBorder(),
            disabledBorder: buildBorder(),
            enabledBorder: buildBorder(),
            focusedBorder: buildBorder(),
            hintText: hintText,
            hintStyle: TextStyle(
              color: AppColors.black.withOpacity(0.3),
              fontSize: 12.sp,
              fontWeight: FontWeight.w300,
            ),
            errorText: errorText,
          ),
          items: items.map((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(itemLabelBuilder?.call(item) ?? item.toString()),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        width: 1,
        color: AppColors.textfieldBorderColor,
      ),
    );
  }
}
