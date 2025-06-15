import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/domain/repositories/user_repository.dart';
import 'package:bloc_clean_arch/presentation/presentation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? username;
  String? email;

  late String oldusername;
  late String oldemail;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();

  @override
  void initState() {
    oldusername = context.read<UserRepository>().getUserName().fold(
      (_) => 'user',
      (value) => value,
    );

    oldemail = context.read<UserRepository>().getUserEmail().fold(
      (_) => 'email unavailable',
      (value) => value,
    );

    _usernameTextEditingController.text = oldusername;
    _emailTextEditingController.text = oldemail;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(Globals.editProfilePageTitle),
        actions: [
          if (hasChanged())
            IconButton(
              icon: const Icon(CupertinoIcons.checkmark_alt),
              onPressed: () {
                if (hasChanged()) {
                  if (_formKey.currentState!.validate()) {
                    oldusername != username
                        ? print(
                          'Username changed from $oldusername to $username',
                        )
                        : null;
                    oldemail != email
                        ? print('Email changed from $oldemail to $email')
                        : null;
                  }
                }
              },
            ),
        ],
      ),

      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              CustomTextFieldFormWidget(
                label: Globals.usernameTextFieldLabel,
                prefixIcon: Icons.person,
                controller: _usernameTextEditingController,
                validator:
                    (value) => FormValidation.usernameValidator(
                      value,
                      _usernameTextEditingController,
                    ),
                onChanged: (value) {
                  setState(() {
                    username = value;
                  });
                },
              ),
              CustomTextFieldFormWidget(
                label: Globals.emailTextFieldLabel,
                prefixIcon: Icons.email,
                controller: _emailTextEditingController,
                validator: FormValidation.emailValidator,
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),

              // password field
              // CustomButtonWidget(
              //   child: const Text('Update'),
              //   onPressed: () {
              //     if (hasChanged()) {
              //       if (_formKey.currentState!.validate()) {
              //         print('Username changed from $oldusername to $username');
              //         print('Email changed from $oldemail to $email');
              //       }
              //     }
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  bool hasChanged() {
    final hasUsernameChanged = username != oldusername && username != null;
    final hasEmailChanged = email != oldemail && email != null;

    return hasUsernameChanged || hasEmailChanged;
  }
}
