import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      width: 0.7 * MediaQuery.of(context).size.width,
      child: TextFormField(
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
                : widget.label == 'Email'
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
          prefixIcon: FaIcon(widget.prefixIcon, size: 22),
          prefixIconColor: AppColors.defaultIconColor,
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
            borderSide: BorderSide(color: AppColors.errorColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: AppDimensions.unfocussedCircleBorderRadius,
            borderSide: BorderSide(color: AppColors.unselectedItemColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: AppDimensions.focussedCircleBorderRadius,
            borderSide: BorderSide(
              color: AppColors.selectedItemColor,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
