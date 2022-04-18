import 'package:flutter/material.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/widgets/appbar_circles.dart';
import '../app_theme.dart';

extension ShowSnackbar on BuildContext {
  void showSnackbar({
    required String message,
    required GlobalKey<ScaffoldMessengerState> key,
  }) {
    key.currentState!.showSnackBar(
      SnackBar(
        content: Row(
          children: <Widget>[
            const Icon(
              Icons.info_outline,
              color: LdColors.orangePrimary,
              size: 25,
            ),
            const SizedBox(
              width: 15,
            ),
            Flexible(
              child: Text(
                message,
                style: Theme.of(this).textTheme.textSmallBlack.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ],
        ),
        backgroundColor: LdColors.white,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void showSnackbarConnectivity({
    required String message,
    required BuildContext context,
    required GlobalKey<ScaffoldMessengerState> key,
  }) {
    key.currentState!.showSnackBar(
      SnackBar(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        content: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: <Widget>[
            const CircleDecoration(quarter: 1, color: LdColors.orangePrimary),
            const CircleDecoration(quarter: 2, color: LdColors.orangePrimary),
            const CircleDecoration(quarter: 3, color: LdColors.orangePrimary),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(
                    Icons.wifi_off,
                    color: LdColors.orangePrimary,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Flexible(
                    child: Text(
                      message,
                      style: Theme.of(this).textTheme.textSmallBlack.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: LdColors.white,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void showSuccessSnackbar({
    required String message,
    required GlobalKey<ScaffoldMessengerState> key,
  }) {
    key.currentState!.showSnackBar(
      SnackBar(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        content: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: <Widget>[
            const CircleDecoration(quarter: 1, color: LdColors.green),
            const CircleDecoration(quarter: 2, color: LdColors.green),
            const CircleDecoration(quarter: 3, color: LdColors.green),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
              child: Row(
                children: <Widget>[
                  Container(
                    decoration: const ShapeDecoration(
                      color: LdColors.white,
                      shape: CircleBorder(
                        side: BorderSide(
                          width: 2,
                          color: LdColors.green,
                        ),
                      ),
                    ),
                    child: const Icon(
                      Icons.done,
                      color: LdColors.green,
                      size: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: Text(
                      message,
                      style: Theme.of(this).textTheme.textSmallBlack.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: LdColors.white,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void showErrorSnackbar({
    required String message,
    required GlobalKey<ScaffoldMessengerState> key,
  }) {
    key.currentState!.showSnackBar(
      SnackBar(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        content: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: <Widget>[
            const CircleDecoration(quarter: 1, color: LdColors.redError),
            const CircleDecoration(quarter: 2, color: LdColors.redError),
            const CircleDecoration(quarter: 3, color: LdColors.redError),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.warning_amber,
                    color: LdColors.redError,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Text(
                      message,
                      style: Theme.of(this).textTheme.textSmallBlack.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: LdColors.white,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
