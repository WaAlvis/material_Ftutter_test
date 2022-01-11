import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_colors.dart';

class InputTextCustom extends StatelessWidget {
  InputTextCustom(
    this.data, {
    Key? key,
    this.textInputAction,
    this.styleLabel,
    this.styleHint,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.controller,
    this.keyboardType,
    this.validator,
    this.onChange,
    this.inputFormatters,
    this.onTap,
    this.autocorrect = false,
    this.onFieldSubmitted,
    this.textCapitalization = TextCapitalization.none,
    this.changeFillWith,
    this.onEditingComplete,
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
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? onTap;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final bool autocorrect;
  final void Function()? onEditingComplete;
  final TextCapitalization textCapitalization;

  bool? changeFillWith = false;
  static const BorderRadius radioBorderConst = BorderRadius.all(
    Radius.circular(12),
  );

  /**
   * <TextInputFormatter> sin escpacios [inputFormatters] * tipo de entrada
   * FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
   *   ],
   */

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

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
          onTap: onTap,
          onEditingComplete: onEditingComplete,
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChange,
          cursorColor: LdColors.orangePrimary,
          cursorHeight: 24,
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          obscureText: obscureText,
          controller: controller,
          autocorrect: autocorrect,
          inputFormatters: inputFormatters,
          validator: validator,
          textCapitalization: textCapitalization,
          decoration: InputDecoration(
            fillColor: LdColors.grayBorder,
            filled: changeFillWith,
            border: const OutlineInputBorder(
              borderRadius: radioBorderConst,
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: radioBorderConst,
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: radioBorderConst,
              borderSide: BorderSide(
                color: LdColors.orangePrimary,
                width: 1.5,
              ),
            ),
            hintStyle: styleHint ?? textTheme.textGray,
            hintText: hintText,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
