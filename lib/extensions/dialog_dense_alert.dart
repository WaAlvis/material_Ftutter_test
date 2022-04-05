import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localdaily/commons/ld_colors.dart';

import '../app_theme.dart';

extension ShowDialogDenseAlert on BuildContext {
  void showDialogDenseAlert({
    String? image,
    required String title,
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
                  if (image != null && image != '')
                    Container(
                      height: 150,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: SvgPicture.asset(image),
                    ),
                  Flexible(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        child: Column(
                          children: <Widget>[
                            Text(
                              title,
                              style: textTheme.textBigBlack.copyWith(
                                color: LdColors.orangePrimary,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Text(
                                message,
                                style: textTheme.textBlack.copyWith(
                                  fontSize: 16,
                                  color: LdColors.blackText,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
                  if (btnTextSecondary != null && onTapSecondary != null)
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
        );
      },
    );
  }
}
