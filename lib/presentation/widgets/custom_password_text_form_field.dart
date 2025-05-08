import 'package:flutter/material.dart';

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
      //TODO : change with different screen sizes not const for all
      width: 0.70 * MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 8),
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
          label: Text(
            widget.label,
            // style: Helpers.getTextTheme(context).bodyMedium?.copyWith(
            //   color: GuardianAppColors.formFieldLabelColor,
            // ),
          ),
          prefixIcon: FaIcon(Icons.lock_outline, size: 22),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: ,
            borderSide: BorderSide(
              color: ,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: ,
            borderSide: BorderSide(
              color: ,
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
