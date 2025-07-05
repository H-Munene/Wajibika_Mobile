import 'package:bloc_clean_arch/core/core.dart'; // Ensure this path is correct and defines AppDimensions
import 'package:flutter/material.dart';

enum NotificationType { success, error, warning }

class SnackbarDefinition {
  static void _displaySnackbar(
    NotificationType notificationType,
    String content,
    BuildContext context,
  ) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content, textAlign: TextAlign.center),
        backgroundColor:
            notificationType == NotificationType.success
                ? Colors.green
                : notificationType == NotificationType.error
                ? Colors.red
                : Colors.orange,
        shape: ContinuousRectangleBorder(
          // Ensure AppDimensions.circleBorderRadius is defined in core.dart
          borderRadius: AppDimensions.circleBorderRadius,
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(10),
      ),
    );
  }

  // Success snackbar
  static void showSuccessSnackbar({
    required BuildContext context,
    required String message,
  }) {
    _displaySnackbar(NotificationType.success, message, context);
  }

  // Error snackbar
  static void showErrorSnackbar({
    required BuildContext context,
    required String message,
  }) {
    _displaySnackbar(NotificationType.error, message, context);
  }

  // Warning snackbar
  static void showWarningSnackbar({
    required BuildContext context,
    required String message,
  }) {
    _displaySnackbar(NotificationType.warning, message, context);
  }
}

// static void successSnackBar({
//   required BuildContext context,
//   required String message,
// }) {
//   CherryToast.success(
//     animationType: AnimationType.fromTop,
//     title: const Text(
//       'Success',
//       style: TextStyle(fontWeight: FontWeight.bold),
//       textAlign: TextAlign.center,
//     ),
//     description: Text(message),
//     displayCloseButton: false,
//   ).show(context);
// }

// static void errorSnackBar({
//   required BuildContext context,
//   required String message,
// }) {
//   CherryToast.error(
//     animationType: AnimationType.fromTop,
//     title: const Text(
//       'Error',
//       style: TextStyle(fontWeight: FontWeight.bold),
//       textAlign: TextAlign.center,
//     ),
//     description: Text(message),
//     displayCloseButton: false,
//   ).show(context);
// }

// static void warningSnackbar({
//   required BuildContext context,
//   required String message,
// }) {
//   CherryToast.warning(
//     animationType: AnimationType.fromTop,
//     title: const Text(
//       'Warning',
//       style: TextStyle(fontWeight: FontWeight.bold),
//       textAlign: TextAlign.center,
//     ),
//     description: Text(message),
//     displayCloseButton: false,
//   )
//   .show(context);
// }
// }

// enum NotificationType { success, error, warning }

// class DisplaySnackBar {
//   static SnackBar _displaySnackbar(
//     NotificationType notificationType,
//     String content,
//   ) {
//     return SnackBar(
//       content: Text(content, textAlign: TextAlign.center),
//       backgroundColor:
//           notificationType == NotificationType.success
//               ? Colors.black
//               : notificationType == NotificationType.error
//               ? Colors.red
//               : Colors.orange,
//       shape: ContinuousRectangleBorder(
//         borderRadius: Globals.cardFieldBorderRadius,
//       ),
//     );
//   }

//   //success snackbar
//   static SnackBar showSuccessSnackbar(String content) {
//     return _displaySnackbar(NotificationType.success, content);
//   }

//   //error snackbar
//   static SnackBar showErrorSnackbar(String content) {
//     return _displaySnackbar(NotificationType.error, content);
//   }

//   //warning snackbar
//   static SnackBar showWarningSnackbar(String content) {
//     return _displaySnackbar(NotificationType.warning, content);
//   }
// }
