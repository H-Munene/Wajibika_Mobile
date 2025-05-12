import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:cherry_toast/resources/arrays.dart';

class SnackbarDefinition {
  static void successSnackBar({
    required BuildContext context,
    required String message,
  }) {
    CherryToast.success(
      animationType: AnimationType.fromTop,
      title: const Text(
        'Success',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      description: Text(message),
      displayCloseButton: false,
    ).show(context);
  }

  static void errorSnackBar({
    required BuildContext context,
    required String message,
  }) {
    CherryToast.error(
      animationType: AnimationType.fromTop,
      title: const Text('Error', style: TextStyle(fontWeight: FontWeight.bold)),
      description: Text(message),
      displayCloseButton: false,
    ).show(context);
  }

  static void warningSnackbar({
    required BuildContext context,
    required String message,
  }) {
    CherryToast.warning(
      animationType: AnimationType.fromTop,
      title: const Text(
        'Warning',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      description: Text(message),
      displayCloseButton: false,
    ).show(context);
  }
}
