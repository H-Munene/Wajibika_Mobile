import 'package:bloc_clean_arch/presentation/form_validator.dart';
import 'package:bloc_clean_arch/presentation/pages/auth/home.dart';
import 'package:bloc_clean_arch/presentation/pages/auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFieldFormWidget(
                    label: 'Email',
                    prefixIcon: FontAwesomeIcons.envelope,
                    controller: _emailTextEditingController,
                    validator: FormValidation.emailValidator,
                  ),
                  CustomPasswordTextformfield(
                    controller: _passwordTextEditingController,
                    label: 'Password',
                    validator: FormValidation.passwordValidator,
                  ),
                ],
              ),
            ),

            CustomButtonWidget(text: 'Login', onPressed: _onLoginPresssed),

            CustomRichText(
              regularText: "Don't have an account yet? ",
              highlightedText: 'Sign Up',
              redirect:
                  () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const SignUpPage()),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  void _onLoginPresssed() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }
}
