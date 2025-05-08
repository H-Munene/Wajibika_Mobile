import 'package:bloc_clean_arch/presentation/form_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widgets/widgets.dart';
import '../../../core/core.dart';

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

            MaterialButton(
              onPressed: () {},
              color: AppColors.buttonBackgroundColor,
              child: const Text('Login'),
            ),

            const SizedBox(height: 10),

            RichText(
              text: TextSpan(
                text: "Don't have an account? ",
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  TextSpan(
                    text: 'Sign up',
                    style: TextStyle(color: AppColors.richTextHighlight),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
