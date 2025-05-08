import 'package:bloc_clean_arch/core/colors.dart';
import 'package:bloc_clean_arch/presentation/form_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../widgets/widgets.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final TextEditingController _confirmPasswordTextEditingController =
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
                    validator:
                        (value) => FormValidation.matchpasswordValidator(
                          value,
                          _confirmPasswordTextEditingController.text.trim(),
                        ),
                  ),
                  CustomPasswordTextformfield(
                    controller: _confirmPasswordTextEditingController,
                    label: 'Confirm Password',
                    validator:
                        (value) => FormValidation.matchpasswordValidator(
                          value,
                          _passwordTextEditingController.text.trim(),
                        ),
                  ),
                ],
              ),
            ),

MaterialButton(
              onPressed: () {},
              color: AppColors.buttonBackgroundColor,
            ),

            const SizedBox(height: 10,),
            
            RichText(
              text: TextSpan(
                text: 'Already registered? ',
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                    text: 'Login',
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
