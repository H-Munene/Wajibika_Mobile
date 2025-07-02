import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:bloc_clean_arch/presentation/presentation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final TextEditingController _currentPasswordTextEditingController =
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

  Future<void> _selectProfilePicture(bool showRemoveMediaActionbutton) async {
    CustomDialogBottomAppSheet.mediaSelectionBottomSheet(
      context: context,
      onCameraSelected: () {
        Navigator.of(context).pop();
        context.read<ProfileMediaBloc>().add(
          ProfileMediaChangeProfilePictureFromCameraEvent(),
        );
      },
      onGallerySelected: () {
        Navigator.of(context).pop();
        context.read<ProfileMediaBloc>().add(
          ProfileMediaChangeProfilePictureFromGalleryEvent(),
        );
      },
      showRemoveMediaActionbutton: showRemoveMediaActionbutton,
      onRemoveMediaSelected: () {
        Navigator.of(context).pop();
        context.read<ProfileMediaBloc>().add(
          ProfileMediaRemoveCurrentProfilePictureEvent(),
        );
      },
    );
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
            BlocBuilder<ChangeDetailsBloc, ChangeDetailsState>(
              builder: (context, state) {
                return state.isLoading
                    ? const CustomLoadingIndicator(color: Colors.white)
                    : IconButton(
                      icon: const Icon(CupertinoIcons.checkmark_alt),
                      onPressed: submit,
                    );
              },
            ),
        ],
      ),

      body: BlocConsumer<ChangeDetailsBloc, ChangeDetailsState>(
        listener: (context, state) {
          if (state.isSuccessful == false) {
            SnackbarDefinition.errorSnackBar(
              context: context,
              message: 'Failed to update details.',
            );
          }

          if (state.isSuccessful == true) {
            SnackbarDefinition.successSnackBar(
              context: context,
              message: 'Successfully updated your credentials.',
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    spacing: 7,
                    children: [
                      const SizedBox(height: 10),
                      BlocBuilder<ProfileMediaBloc, ProfileMediaState>(
                        builder: (context, state) {
                          // if the user has set a profile picture
                          final isThereimageSelected =
                              state.profileMediaStatus ==
                              ProfileMediaStatus.profilePicturePresent;
                          return Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: CustomUserAvatar(
                              //display the user image when tapped
                              onCameraIconTapped:
                                  () => _selectProfilePicture(
                                    isThereimageSelected,
                                  ),
                              userProfilePicture:
                                  isThereimageSelected
                                      ? state.profilePicture
                                      : '',
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 15),

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
                    ],
                  ),
                ),

                Offstage(
                  offstage: !(email != oldemail && email != null),
                  child: CustomPasswordTextformfield(
                    label: 'Current Password',
                    controller: _currentPasswordTextEditingController,
                    validator: FormValidation.passwordValidator,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  bool hasChanged() {
    final hasUsernameChanged = username != oldusername && username != null;
    final hasEmailChanged = email != oldemail && email != null;

    return hasUsernameChanged || hasEmailChanged;
  }

  void submit() {
    if (hasChanged()) {
      if (_formKey.currentState!.validate()) {
        if (oldusername != _usernameTextEditingController.text &&
            oldemail != _emailTextEditingController.text) {
          context.read<ChangeDetailsBloc>().add(
            ChangeEmailUsernameEvent(
              currentPassword: _currentPasswordTextEditingController.text,
              email: email!,
              username: username!,
            ),
          );

          // update locally saved username
          context.read<UserRepository>().updateUsername(newUsername: username!);
          // update locally saved username and email
          context.read<UserRepository>().updateEmail(newEmail: email!);
        } else if (oldusername != _usernameTextEditingController.text) {
          context.read<ChangeDetailsBloc>().add(
            ChangeUsernameEvent(username: username!),
          );
          // update locally saved username
          context.read<UserRepository>().updateUsername(newUsername: username!);
        } else if (oldemail != _emailTextEditingController.text) {
          context.read<ChangeDetailsBloc>().add(
            ChangeEmailEvent(
              current_password:
                  _currentPasswordTextEditingController.text.trim(),
              email: email!,
            ),
          );
        }
      }
    }
  }
}
