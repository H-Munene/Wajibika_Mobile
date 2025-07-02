import 'package:flutter/material.dart';
import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/presentation/presentation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  void dispose() {
    _usernameTextEditingController.dispose();
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _confirmPasswordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text('Wajibika', style: TextStyle(color: Colors.black)),
      ),
      resizeToAvoidBottomInset: false,
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
                message: 'Sign Up Successful',
              );

              Navigator.of(context).pushReplacement(
                CupertinoPageRoute(builder: (context) => const LoginPage()),
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
                      // username field
                      CustomTextFieldFormWidget(
                        label: Globals.usernameTextFieldLabel,
                        prefixIcon: FontAwesomeIcons.envelope,
                        controller: _usernameTextEditingController,
                        validator:
                            (value) => FormValidation.usernameValidator(
                              value,
                              _usernameTextEditingController,
                            ),
                      ),

                      // email field
                      CustomTextFieldFormWidget(
                        label: Globals.emailTextFieldLabel,
                        prefixIcon: FontAwesomeIcons.envelope,
                        controller: _emailTextEditingController,
                        validator: FormValidation.emailValidator,
                      ),

                      // password field
                      CustomPasswordTextformfield(
                        controller: _passwordTextEditingController,
                        label: Globals.passwordTextFieldLabel,
                        validator:
                            (value) => FormValidation.matchpasswordValidator(
                              value,
                              '${_passwordTextEditingController.text.trim()} ${_confirmPasswordTextEditingController.text.trim()}',
                            ),
                      ),

                      // confirm password field
                      CustomPasswordTextformfield(
                        controller: _confirmPasswordTextEditingController,
                        label: Globals.confirmPasswordTextFieldLabel,
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
                          : Text(
                            'Sign Up',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.white),
                          ),
                ),
                CustomRichText(
                  regularText: 'Already Registered? ',
                  highlightedText: 'Login',
                  redirect:
                      () => Navigator.of(context).pushAndRemoveUntil(
                        CupertinoPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                        (_) => false,
                      ),
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
