import 'package:flutter/material.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_colors.dart';

class PrimaryButtonCustom extends StatelessWidget {
  const PrimaryButtonCustom(
    this.data, {
    Key? key,
    this.width = double.infinity,
    this.height = 60,
    this.colorButton = LdColors.orangePrimary,
    required this.onPressed,
    this.colorTextBorder,
    this.icon, this.colorText,
  }) : super(key: key);

  final String data;
  final IconData? icon;
  final Color? colorTextBorder;
  final Color colorButton;
  final Color? colorText;
  final Function()? onPressed;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: colorButton,
        minimumSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: colorTextBorder == null
              ? BorderSide.none
              : BorderSide(color: colorTextBorder!, width: 2),
        ),
      ),
      child: icon == null
          ? Text(
              data,
              style:
              textTheme.textWhite
                  .copyWith(color: colorText ??  colorTextBorder ?? LdColors.black),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  icon,
                  color: colorTextBorder ?? LdColors.black,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  data,
                  style: textTheme.textWhite
                      .copyWith(color: colorTextBorder ?? LdColors.black),
                ),
              ],
            ),
    );
  }
}
