import 'package:bloc_clean_arch/presentation/form_validator.dart';
import 'pages.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  static Route loginPage() =>
      MaterialPageRoute(builder: (context) => const LoginPage());

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
                  () => Navigator.of(
                    context,
                  ).pushReplacement(SignUpPage.signUpPage()),
            ),
          ],
        ),
      ),
    );
  }

  void _onLoginPresssed() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pushReplacement(HomePage.homePage());
    }
  }
}
