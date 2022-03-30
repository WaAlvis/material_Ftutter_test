import 'package:flutter/material.dart';
import 'package:localdaily/commons/ld_colors.dart';

import '../app_theme.dart';

extension ShowDialogGenericAlert on BuildContext {
  void showDialogGenericAlert({
    required String message,
    required String btnText,
    required VoidCallback onTap,
    String? btnTextSecondary,
    VoidCallback? onTapSecondary,
  }) {
    final TextTheme textTheme = Theme.of(this).textTheme;
    final Size size = MediaQuery.of(this).size;

    showDialog(
      context: this,
      barrierColor: LdColors.blackDark.withOpacity(0.75),
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            backgroundColor: LdColors.white,
            child: Container(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: message.length > 30 ? 20 : size.width * 0.1,
                    ),
                    child: Text(
                      message,
                      style: textTheme.textBlack.copyWith(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  MaterialButton(
                    color: LdColors.orangePrimary,
                    minWidth: double.maxFinite,
                    height: 42,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    disabledColor: LdColors.orangePrimary.withOpacity(0.7),
                    onPressed: onTap,
                    child: Text(
                      btnText,
                      style: textTheme.textBlack.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (btnTextSecondary != null && onTapSecondary != null)
                    MaterialButton(
                      color: LdColors.white,
                      minWidth: double.maxFinite,
                      height: 42,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                          width: 2,
                          color: LdColors.orangePrimary,
                        ),
                      ),
                      disabledColor: LdColors.orangePrimary.withOpacity(0.7),
                      onPressed: onTapSecondary,
                      child: Text(
                        btnTextSecondary,
                        style: textTheme.textBlack.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
