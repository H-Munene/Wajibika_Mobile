import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../widgets/widgets.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
                  CustomTextFieldFormWidget(label: 'Email', prefixIcon: FontAwesomeIcons.envelope, controller: controller, validator: validator)
        ,CustomPasswordTextformfield(controller: controller, label: 'Password', validator: validator)
        ,CustomPasswordTextformfield(controller: controller, label: 'Confirm Password', validator: validator);
        
        ],
      ),
    ));
  }
}
