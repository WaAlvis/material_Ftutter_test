import 'package:flutter/material.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_colors.dart';

class DropdownCustom extends StatelessWidget {
  const DropdownCustom(
    this.data, {
    Key? key,
    required this.hintText,
    required this.optionItems,
    required this.onChanged,
    required this.value,
    this.changeFillWith = false,
    this.validator,
  }) : super(key: key);

  final String data;
  final String hintText;
  final List<DropdownMenuItem<String>>? optionItems;
  final void Function(String?)? onChanged;
  final String? value;
  final String? Function(String?)? validator;
  final bool? changeFillWith;

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
            style: textTheme.textBlack,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        DropdownButtonFormField<String>(
          validator: validator,
          value: value,
          decoration: InputDecoration(
            filled: changeFillWith,
            fillColor: LdColors.grayBorder,
            hintText: hintText,
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: LdColors.orangePrimary),
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            // filled: changeFillWith != null ,
          ),
          items: optionItems,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
