import 'package:flutter/material.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/extensions/dialog_dense_alert.dart';
import 'package:localdaily/extensions/dialog_generic_alert.dart';
import 'package:localdaily/extensions/dialog_loading.dart';

class LdDialog {
  LdDialog._();

  static void buildGenericAlertDialog(
    BuildContext context, {
    required String message,
    required String btnText,
    required VoidCallback onTap,
    String? btnTextSecondary,
    VoidCallback? onTapSecondary,
  }) {
    context.showDialogGenericAlert(
      message: message,
      btnText: btnText,
      onTap: onTap,
      btnTextSecondary: btnTextSecondary,
      onTapSecondary: onTapSecondary,
    );
  }

  static void buildDenseAlertDialog(
    BuildContext context, {
    String? image,
    required String title,
    required String message,
    required String btnText,
    required VoidCallback onTap,
    String? btnTextSecondary,
    VoidCallback? onTapSecondary,
  }) {
    context.showDialogDenseAlert(
      image: image,
      title: title,
      message: message,
      btnText: btnText,
      onTap: onTap,
      btnTextSecondary: btnTextSecondary,
      onTapSecondary: onTapSecondary,
    );
  }

  static void buildLoadingDialog(BuildContext context) {
    LdRouter().navigatorKey.currentContext!.showDialogLoading();
  }
}
