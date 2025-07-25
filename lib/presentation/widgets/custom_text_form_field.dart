import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/core.dart';

class CustomTextFieldFormWidget extends StatefulWidget {
  final String label;
  final IconData prefixIcon;
  final Icon? suffixIcon;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final bool? enabled;
  final void Function(String)? onChanged;
  final bool? fillColor;
  final TextInputType? keyboardType;
  final String? hintText;
  final bool hasMaxLines;

  const CustomTextFieldFormWidget({
    super.key,
    required this.label,
    required this.prefixIcon,
    this.suffixIcon,
    this.fillColor = false,
    this.enabled = true,
    required this.controller,
    required this.validator,
    this.onChanged,
    this.keyboardType,
    this.hintText,
    this.hasMaxLines = false,
  });

  @override
  State<CustomTextFieldFormWidget> createState() =>
      _CustomTextFieldFormWidgetState();
}

class _CustomTextFieldFormWidgetState extends State<CustomTextFieldFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppDimensions.textfieldVerticalSpacing,
      width: 0.75 * MediaQuery.of(context).size.width,
      child: TextFormField(
        maxLength: widget.hasMaxLines ? 60 : null,
        maxLines: widget.hasMaxLines ? 3 : null,
        enableInteractiveSelection: false,
        inputFormatters:
            widget.label == 'Phone Number' ||
                    widget.label == 'Recovery Phone Number'
                ? [
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.digitsOnly,
                ]
                : null,
        keyboardType:
            widget.keyboardType ??
            (widget.label == 'Phone Number'
                ? TextInputType.number
                : widget.label == Globals.emailTextFieldLabel
                ? TextInputType.emailAddress
                : TextInputType.text),
        controller: widget.controller,
        validator: widget.validator,
        textInputAction: TextInputAction.next,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        enabled: widget.enabled,
        cursorColor: AppColors.primaryColor,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: widget.hintText,

          suffixIconColor: AppColors.defaultIconColor,
          labelText: widget.label,
          labelStyle: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.labelColor),
          border: OutlineInputBorder(
            borderRadius: AppDimensions.unfocussedCircleBorderRadius,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: AppDimensions.focussedCircleBorderRadius,
            borderSide: const BorderSide(color: AppColors.errorColor, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: AppDimensions.unfocussedCircleBorderRadius,
            borderSide: const BorderSide(color: AppColors.unselectedItemColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: AppDimensions.focussedCircleBorderRadius,
            borderSide: const BorderSide(
              color: AppColors.selectedItemColor,
              width: 2,
            ),
          ),
          errorStyle: const TextStyle(color: AppColors.errorColor),
        ),
      ),
    );
  }
}
