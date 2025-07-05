import 'dart:convert';

import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/core/secrets/localhost_endpoints.dart';
import 'package:bloc_clean_arch/presentation/pages/auth/reset_password.dart';
import 'package:bloc_clean_arch/presentation/presentation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class RequestResetPasswordPage extends StatefulWidget {
  const RequestResetPasswordPage({super.key});

  @override
  State<RequestResetPasswordPage> createState() =>
      _RequestResetPasswordPageState();
}

class _RequestResetPasswordPageState extends State<RequestResetPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailTextEditingController =
      TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Reset Password')),
      body: Center(
        child: Column(
          spacing: 10,
          children: [
            const SizedBox(height: 180),

            const Text(
              'Please enter your registered email below',
              style: TextStyle(color: AppColors.labelColor),
            ),
            Form(
              key: _formKey,
              child: CustomTextFieldFormWidget(
                label: Globals.emailTextFieldLabel,
                prefixIcon: FontAwesomeIcons.envelope,
                controller: _emailTextEditingController,
                validator: FormValidation.emailValidator,
              ),
            ),

            CustomButtonWidget(
              onPressed: _onResetPressed,
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

  Future<void> _onResetPressed() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = !isLoading;
      });
      final Uri url = Uri.parse(
        LocalhostEndpoints.requestPasswordResetEndpoint,
      );

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

        body: jsonEncode({'email': _emailTextEditingController.text.trim()}),
      );

      // redirect to reset page regardless of whether email is present or not
      await Navigator.of(context).pushReplacement(
        CupertinoPageRoute(
          builder:
              (context) => ResetPasswordPage(
                email: _emailTextEditingController.text.trim(),
              ),
        ),
      );
    }
  }
}
