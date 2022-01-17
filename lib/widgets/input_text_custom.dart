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
    this.hintStyle,
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
    this.style,
  }) : super(key: key);

  final void Function(String)? onChange;
  final TextStyle? styleLabel;
  final TextStyle? hintStyle;
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
  final TextStyle? style;

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
          style: style,

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
            hintStyle: hintStyle ?? textTheme.textGray,
            hintText: hintText,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}


class ThousandsSeparatorInputFormatter extends TextInputFormatter {

  static const String separator = '.'; // Change this to '.' for other locales

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue,) {

    // En caso de que se eliminen los separadores de miles, se retorna el valor anterior.
    if(oldValue.text.contains(separator) &&
        !newValue.text.contains(separator) &&
        oldValue.text.replaceAll(separator, '').length == newValue.text.length){
      return oldValue;
    }

    // Short-circuit if the new value is empty
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Handle "deletion" of separator character
    final String oldValueText = oldValue.text.replaceAll(separator, '');
    String newValueText = newValue.text.replaceAll(separator, '');

    if (oldValue.text.endsWith(separator) &&
        oldValue.text.length == newValue.text.length + 1) {
      newValueText = newValueText.substring(0, newValueText.length - 1);
    }

    // Only process if the old value and new value are different
    if (oldValueText != newValueText) {
      final int selectionIndex =
          newValue.text.length - newValue.selection.extentOffset;
      final List<String> chars = newValueText.split('');

      String newString = '';
      for (int i = chars.length - 1; i >= 0; i--) {
        if ((chars.length - 1 - i) % 3 == 0 && i != chars.length - 1) {
          newString = separator + newString;
        }
        newString = chars[i] + newString;
      }

      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndex,
        ),
      );
    }

    // If the new value and old value are the same, just return as-is
    return newValue;
  }
}
