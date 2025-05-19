import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/constant/app_colors.dart';

// final List<String> items = ['Item1', 'Item2', 'Item3', 'Item4'];
// List<DropDownModel> selectedItems = [];

class AddOfferDropDown extends StatelessWidget {
  AddOfferDropDown({
    super.key,
    this.title,
    this.toolTipMessage,
    required this.items,
    this.selectedItems = const [],
    this.onChanged,
  });

  final String? title;
  final String? toolTipMessage;
  final List<DropDownModel> items;
  final List<DropDownModel> selectedItems;
  final Function? onChanged;

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
                children: [
                  Text(
                    title!,
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (toolTipMessage != null)
                    Tooltip(
                      message: toolTipMessage ?? "",
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
        Container(
          decoration: BoxDecoration(
            color: AppColors.textfieldColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.textfieldBorderColor,
              width: 1,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<int>(
              isExpanded: true,
              hint: Text(
                'Select Items',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.black.withOpacity(0.3),
                  fontWeight: FontWeight.w300,
                ),
              ),
              items: items.map((item) {
                return DropdownMenuItem<int>(
                  value: item.id,
                  enabled: false,
                  child: StatefulBuilder(
                    builder: (context, menuSetState) {
                      final isSelected = selectedItems.any((selectedItem) => selectedItem.id == item.id);
                      return InkWell(
                        onTap: () {
                          if (isSelected) {
                            selectedItems.removeWhere((selectedItem) => selectedItem.id == item.id);
                          } else {
                            selectedItems.add(item);
                          }
                          // isSelected ? selectedItems.remove(item) : selectedItems.add(item);
                          menuSetState(() {});
                          onChanged?.call(selectedItems);
                        },
                        child: Container(
                          height: double.infinity,
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              Icon(
                                isSelected ? Icons.check_box_outlined : Icons.check_box_outline_blank,
                                size: 18,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  item.name ?? '',
                                  style: TextStyle(fontSize: 12.sp),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
              value: selectedItems.isEmpty ? null : selectedItems.last.id,
              onChanged: (value) {},
              selectedItemBuilder: (context) {
                return items.map(
                  (item) {
                    return Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        selectedItems.map((e) => e.name).join(', '),
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                    );
                  },
                ).toList();
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 12),
                height: 48,
                width: double.infinity,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
                padding: EdgeInsets.zero,
              ),
              iconStyleData: IconStyleData(
                icon: const Icon(Icons.keyboard_arrow_down),
                iconSize: 20.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DropDownModel {
  final String? name;
  final int? id;

  DropDownModel({this.name, this.id});

  factory DropDownModel.fromJson(Map<String, dynamic> json) {
    return DropDownModel(
      name: json['name'] as String?,
      id: json['id'] as int?,
    );
  }
}
