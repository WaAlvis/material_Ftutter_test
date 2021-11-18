import 'package:flutter/material.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
    this.data, {
    Key? key, this.colorButton=LdColors.orangePrimary, required this.onPressed,
  }) : super(key: key);

  final String data;
  final Color colorButton;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: colorButton,
        minimumSize: const Size(double.infinity, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      child: Text(
        data,
        style: textTheme.textWhite,
      ),
    );
  }
}
