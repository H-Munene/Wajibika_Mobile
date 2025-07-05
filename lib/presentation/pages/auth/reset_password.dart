import 'dart:convert';

import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/core/secrets/localhost_endpoints.dart';
import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:bloc_clean_arch/presentation/presentation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ResetPasswordPage extends StatefulWidget {
  final String email;
  const ResetPasswordPage({super.key, required this.email});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final TextEditingController _confirmPasswordTextEditingController =
      TextEditingController();
  final TextEditingController _tokenTextEditingController =
      TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    _passwordTextEditingController.dispose();
    _confirmPasswordTextEditingController.dispose();
    _tokenTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Reset Password')),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 180),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // token
                  CustomTextFieldFormWidget(
                    label: 'Token',
                    prefixIcon: FontAwesomeIcons.envelope,
                    controller: _tokenTextEditingController,
                    validator: (token) {
                      return token == null || token.isEmpty
                          ? 'Password reset token is required'
                          : null;
                    },
                  ),

                  CustomPasswordTextformfield(
                    controller: _passwordTextEditingController,
                    label: 'New Password',
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
              onPressed: () async {
                await _onResetPresssed();
              },
              child:
                  isLoading
                      ? const CustomLoadingIndicator()
                      : Text(
                        'Reset',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                      ),
            ),
          ],
        ),
      ),
    );
  }

  // reset password
  Future<void> _onResetPresssed() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = !isLoading;
      });

      final Uri url = Uri.parse(LocalhostEndpoints.resetPassword);

      final request = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
          'Access-Control-Allow-Headers':
              'Origin, Content-Type, X-Auth-Token, Authorization',
        },
        body: jsonEncode({
          'email': widget.email,
          'token': _tokenTextEditingController.text.trim(),
          'new_password': _confirmPasswordTextEditingController.text,
        }),
      );

      if (request.statusCode == 200) {
        setState(() {
          isLoading = !isLoading;
        });
        SnackbarDefinition.showSuccessSnackbar(
          context: context,
          message: 'Password Reset Successful',
        );

        // redirect to the login page
        await Future.delayed(const Duration(milliseconds: 700), () {
          Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(builder: (context) => const LoginPage()),
            (_) => false,
          );
        });
      } else {
        setState(() {
          isLoading = !isLoading;
        });
        SnackbarDefinition.showErrorSnackbar(
          context: context,
          message: 'Password Reset Failed',
        );
      }
    }
  }
}
