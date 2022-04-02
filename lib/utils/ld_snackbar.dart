import 'package:flutter/material.dart';
import 'package:localdaily/extensions/snackbar_message.dart';

class LdSnackbar {
  LdSnackbar._();

  static GlobalKey<ScaffoldMessengerState> key =
      GlobalKey<ScaffoldMessengerState>();

  static void buildSnackbar(
    BuildContext context,
    String message,
    int duration,
  ) {
    context.showSnackbar(message: message, duration: duration, key: key);
  }

  static void buildConnectivitySnackbar(BuildContext context, String message) {
    context.showSnackbarConnectivity(
      message: message,
      context: context,
      key: key,
    );
  }

  static void buildSuccessSnackbar(
    BuildContext context,
    String message,
    int duration,
  ) {
    context.showSuccessSnackbar(message: message, duration: duration, key: key);
  }

  static void buildErrorSnackbar(BuildContext context, String message) {
    context.showErrorSnackbar(message: message, key: key);
  }
}
