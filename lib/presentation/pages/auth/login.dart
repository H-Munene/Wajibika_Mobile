import 'package:bloc_clean_arch/presentation/pages/auth/request_reset_password.dart';
import 'package:flutter/material.dart';
import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/presentation/presentation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  void dispose() {
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            } else if (state is AuthLoggedIn) {
              Navigator.of(context).pushReplacement(
                CupertinoPageRoute(builder: (context) => const BottomNav()),
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
                        validator: FormValidation.passwordValidator,
                      ),
                    ],
                  ),
                ),

                CustomButtonWidget(
                  onPressed: _onLoginPresssed,
                  child:
                      state is AuthLoading
                          ? const CustomLoadingIndicator()
                          : Text(
                            'Login',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.white),
                          ),
                ),

                // redirect to sign up
                CustomRichText(
                  regularText: "Don't have an account yet? ",
                  highlightedText: 'Sign Up',
                  redirect:
                      () => Navigator.of(context).push(SignUpPage.signUpPage()),
                ),

                // password reset
                const SizedBox(height: 10),
                CustomRichText(
                  regularText: '',
                  highlightedText: 'Forgot Password?',
                  redirect:
                      () => Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder:
                              (context) => const RequestResetPasswordPage(),
                        ),
                      ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _onLoginPresssed() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        AuthLogin(
          email: _emailTextEditingController.text.trim(),
          password: _passwordTextEditingController.text.trim(),
        ),
      );
    }
  }
}
