import 'package:flutter/material.dart';
import 'package:localdaily/commons/ld_colors.dart';

import '../app_theme.dart';

extension ShowDialogWidgetAlert on BuildContext {
  void showDialogWidgetAlert({
    // required String message,
    required Widget customWidget,
    required String title,
    String? btnText,
    VoidCallback? onTap,
    String? btnTextSecondary,
    VoidCallback? onTapSecondary,
    VoidCallback? onTapClose,
  }) {
    final TextTheme textTheme = Theme.of(this).textTheme;
    final Size size = MediaQuery.of(this).size;

    showDialog(
      context: this,
      barrierColor: LdColors.blackDark.withOpacity(0.75),
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            backgroundColor: LdColors.white,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          title,
                          style: textTheme.bodyMedium?.copyWith(fontSize: 18),
                        ),
                        GestureDetector(
                          onTap: onTapClose != null
                              ? onTapClose
                              : () {
                                  print('llego vacio el ontapclose');
                                  Navigator.pop(context);
                                },
                          child: Text('X',
                              style:
                                  textTheme.bodyMedium?.copyWith(fontSize: 18)),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: customWidget,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    if (btnText != null && onTapSecondary != null)
                      MaterialButton(
                        color: LdColors.orangePrimary,
                        minWidth: double.maxFinite,
                        height: 42,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
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
                    if (btnTextSecondary != null && onTap != null)
                      MaterialButton(
                        color: LdColors.white,
                        minWidth: double.maxFinite,
                        height: 42,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
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
          ),
        );
      },
    );
  }
}
