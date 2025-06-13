import 'package:flutter/material.dart';

class FormValidation {
  static String? usernameValidator(
    String? username,
    TextEditingController controller,
  ) {
    if (username == null || username.isEmpty) {
      return 'Name is required';
    } else if (!nameRegExp.hasMatch(username)) {
      controller.clear();
      return 'Name should only have letters and no spaces';
    } else {
      return null;
    }
  }

  //single field password validation i.e in login screen
  static String? passwordValidator(String? password) {
    return (password == null || password.isEmpty)
        ? 'Password is required'
        : !passwordExp.hasMatch(password)
        ? 'Password should have at least 8 characters'
        : null;
  }

  //validate email
  static String? emailValidator(String? email) {
    return (email == null || email.isEmpty)
        ? 'Email is required'
        : !emailRegExp.hasMatch(email)
        ? 'Please enter a valid email address'
        : null;
  }

  //validate phonenumber
  static String? phoneValidator(String? phone) {
    return (phone == null || phone.isEmpty)
        ? 'Phone is required'
        : !phoneRegexExp.hasMatch(phone)
        ? 'Please enter a valid phone number'
        : null;
  }

  //match password and confirm password
  static String? matchpasswordValidator(
    String? value,
    String passwordConfirmPassword,
  ) {
    final password = passwordConfirmPassword.split(' ')[0];
    final confirmPassword = passwordConfirmPassword.split(' ')[1];

    return (value!.isEmpty)
        ? 'Password is required'
        : (!passwordExp.hasMatch(value))
        ? 'Password should have at least 6 characters'
        : (confirmPassword != password)
        ? 'Passwords do not match'
        : null;
  }

  static String? descriptionValidator(String? description) {
    return (description == null || description.isEmpty)
        ? 'Description is required'
        : (description.length < 25)
        ? 'Give detailed description.'
        : null;
  }

  // static otpValidator(String? otpCode) {
  //   return otpCode!.isEmpty || otpCode.length < 6
  //       ? 'OTP Code is required'
  //       : null;
  // }
}

final passwordExp = RegExp(r'^.{6,}$'); //password not less than 6
final nameRegExp = RegExp(r'^[a-zA-Z]+$'); //name regex
final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
final phoneRegexExp = RegExp(r'^\d{10}$');
