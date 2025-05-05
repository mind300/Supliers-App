import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/constant/app_colors.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<CustomDropdownModel> items;
  final CustomDropdownModel? value;
  final String? hintText;
  final void Function(String?) onChanged;
  final String Function(CustomDropdownModel)? itemLabelBuilder;
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
            child: Text(
              title!,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        DropdownButtonFormField<String>(
          value: value?.id,
          hint: Text(hintText ?? '', style: textStyle),
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
            hintStyle: textStyle,
            errorText: errorText,
          ),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item.id,
              child: Text(itemLabelBuilder?.call(item) ?? item.name),
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

class CustomDropdownModel {
  final String name;
  final String id;

  CustomDropdownModel({
    required this.name,
    required this.id,
  });
}
