import 'package:flutter/material.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_colors.dart';

class InputTextCustom extends StatelessWidget {
  const InputTextCustom(
      this.data, {
        Key? key,
        required this.textTheme,
        required this.hintText,
        this.obscureText = false,
        this.suffixIcon, this.controller,
      }) : super(key: key);

  final TextTheme textTheme;
  final String data;
  final bool obscureText;
  final String hintText;
  final Widget? suffixIcon;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          data,
          style: textTheme.textSmallBlack,
        ),
        const SizedBox(height: 5),
        TextFormField(
          obscureText: obscureText,
          controller: controller,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          decoration: InputDecoration(
            hintStyle:
            textTheme.textSmallBlack.copyWith(color: LdColors.grayLight),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            hintText: hintText,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}