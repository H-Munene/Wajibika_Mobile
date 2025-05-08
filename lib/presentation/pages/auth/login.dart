import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: [
        CustomTextFieldFormWidget(label: 'Email', prefixIcon: FontAwesomeIcons.envelope, controller: controller, validator: validator)
        ,CustomPasswordTextformfield(controller: controller, label: 'Password', validator: validator);
      ],),
    ));
  }
}
