import 'package:flutter/material.dart';
import 'package:bloc_clean_arch/core/core.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';

class CustomDropDown extends StatelessWidget {
  final List<String> items;
  final void Function(String?) onChanged;
  final String? hintText;
  final String? initialValue;

  const CustomDropDown({
    super.key,
    required this.items,
    required this.onChanged,
    this.hintText,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.7 * MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: CustomDropdown<String>(
          hintText: hintText,
          items: items,
          onChanged: onChanged,
          initialItem: initialValue,
          validator: (value) {
            return (value == null || value.isEmpty || value == 'Select One')
                ? 'Field is required'
                : null;
          },
          decoration: CustomDropdownDecoration(
            closedBorderRadius: AppDimensions.unfocussedCircleBorderRadius,
            expandedBorderRadius: AppDimensions.circleBorderRadius,
            closedFillColor: Colors.white,
            listItemStyle: const TextStyle(color: Colors.black),
            closedBorder: Border.all(color: AppColors.borderColor),
            closedErrorBorder: Border.all(color: AppColors.errorColor),
            errorStyle: const TextStyle(color: AppColors.errorColor),
          ),
        ),
      ),
    );
  }
}
