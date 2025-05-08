import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/core.dart';

class CustomPasswordTextformfield extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?) validator;

  const CustomPasswordTextformfield({
    super.key,
    required this.controller,
    required this.label,
    required this.validator,
  });

  @override
  State<CustomPasswordTextformfield> createState() =>
      _CustomPasswordTextformfieldState();
}

class _CustomPasswordTextformfieldState
    extends State<CustomPasswordTextformfield> {
  bool visibility = false;

  //toggle password visibility
  void toggleVisibiity() {
    setState(() {
      visibility = !visibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // TODO(H-Munene): make width adaptive, https://github.com/H-Munene/bloc_CleanArch/issues/3  
      width: 0.70 * MediaQuery.of(context).size.width,
      padding: AppDimensions.textfieldVerticalSpacing,
      child: TextFormField(
        enableInteractiveSelection: false,
        keyboardType: TextInputType.text,
        obscureText: !visibility,
        obscuringCharacter: '*',
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        validator: widget.validator,
        controller: widget.controller,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          prefixIconColor: AppColors.defaultIconColor,
          suffixIconColor: AppColors.defaultIconColor,
          label: Text(
            widget.label,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.labelColor),
          ),
          prefixIcon: const FaIcon(
            Icons.lock_outline,
            size: AppDimensions.iconSize,
          ),
          border: OutlineInputBorder(
            borderRadius: AppDimensions.unfocussedCircleBorderRadius,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: AppDimensions.unfocussedCircleBorderRadius,
            borderSide: BorderSide(color: AppColors.unselectedItemColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: AppDimensions.focussedCircleBorderRadius,
            borderSide: BorderSide(color: AppColors.errorColor, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: AppDimensions.focussedCircleBorderRadius,
            borderSide: BorderSide(
              color: AppColors.selectedItemColor,
              width: 2,
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: toggleVisibiity,
            child:
                visibility
                    ? const Icon(FluentIcons.eye_12_regular)
                    : const Icon(FluentIcons.eye_off_16_regular),
          ),
        ),
      ),
    );
  }
}
