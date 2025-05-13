import 'package:bloc_clean_arch/core/snackbar_definitions.dart';
import 'package:bloc_clean_arch/presentation/bloc/auth_bloc.dart';
import 'package:bloc_clean_arch/presentation/form_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../widgets/widgets.dart';

class SignUpPage extends StatefulWidget {
  static Route signUpPage() =>
      MaterialPageRoute(builder: (context) => const SignUpPage());

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final TextEditingController _confirmPasswordTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              SnackbarDefinition.errorSnackBar(
                context: context,
                message: state.message,
              );
            } else if (state is AuthSuccess) {
              SnackbarDefinition.successSnackBar(
                context: context,
                message: 'Signup Success',
              );
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFieldFormWidget(
                        label: 'Username',
                        prefixIcon: FontAwesomeIcons.envelope,
                        controller: _usernameTextEditingController,
                        validator:
                            (value) => FormValidation.usernameValidator(
                              value,
                              _usernameTextEditingController,
                            ),
                      ),

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
                              '${_passwordTextEditingController.text.trim()} ${_confirmPasswordTextEditingController.text.trim()}',
                            ),
                      ),
                      CustomPasswordTextformfield(
                        controller: _confirmPasswordTextEditingController,
                        label: 'Confirm Password',
                        validator:
                            (value) => FormValidation.matchpasswordValidator(
                              value,
                              '${_passwordTextEditingController.text.trim()} ${_confirmPasswordTextEditingController.text.trim()}',
                            ),
                      ),
                    ],
                  ),
                ),

                CustomButtonWidget(
                  onPressed: _onSignUpPressed,
                  child:
                      state is AuthLoading
                          ? const CustomLoadingIndicator()
                          : const Text('Sign Up'),
                ),
                CustomRichText(
                  regularText: 'Already Registered? ',
                  highlightedText: 'Login',
                  redirect:
                      () => Navigator.of(
                        context,
                      ).pushReplacement(LoginPage.loginPage()),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _onSignUpPressed() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        AuthSignUp(
          username: _usernameTextEditingController.text.trim(),
          email: _emailTextEditingController.text.trim(),
          password: _passwordTextEditingController.text.trim(),
        ),
      );
    }
  }
}
