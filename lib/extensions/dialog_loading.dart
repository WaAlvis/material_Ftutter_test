import 'package:flutter/material.dart';
import 'package:localdaily/commons/ld_colors.dart';

extension ShowDialogLoading on BuildContext {
  void showDialogLoading() {
    final Size size = MediaQuery.of(this).size;

    showDialog(
      context: this,
      barrierColor: LdColors.blackDark.withOpacity(0.75),
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.4),
            child: Dialog(
              insetPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(56.0),
              ),
              backgroundColor: LdColors.gray,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: size.width * 0.05, horizontal: size.width * 0.05),
                child: SizedBox(
                  width: size.width * 0.1,
                  height: size.width * 0.1,
                  child: const CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(LdColors.orangePrimary),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
