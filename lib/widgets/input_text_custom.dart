import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localdaily/app_theme.dart';

class InputTextCustom extends StatelessWidget {
  const InputTextCustom(this.data, {
    Key? key,
    this.styleLabel,
    this.styleHint,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.controller,
    this.keyboardType,
    this.onlyIntNum = false,
    this.validator,
    this.onChange,
  }) : super(key: key);

  final void Function(String)? onChange;
  final TextStyle? styleLabel;
  final TextStyle? styleHint;
  final String data;
  final bool obscureText;
  final String hintText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool onlyIntNum;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme
        .of(context)
        .textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            data,
            style: styleLabel ?? textTheme.textBlack,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          onChanged:onChange,
          keyboardType: keyboardType,
          obscureText: obscureText,
          controller: controller,
          inputFormatters:
          onlyIntNum ? [FilteringTextInputFormatter.digitsOnly] : null,
          validator: validator,
          //     (String? value) {
          //   if (value == null || value.isEmpty) {
          //     return '* Este campo es obligatorio';
          //   }
          //   return null;
          // },
          decoration: InputDecoration(
            hintStyle: styleHint ?? textTheme.textGray,
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
