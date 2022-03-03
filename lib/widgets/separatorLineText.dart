import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_colors.dart';

class SeparatorTexLine extends StatelessWidget {

  SeparatorTexLine(this.data, {
    Key? key,
  }) : super(key: key);

  final String data;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme
        .of(context)
        .textTheme;


    return Row(children: <Widget>[
      const SizedBox(
        width: 20,
      ),
      const Expanded(child: Divider()),
      const SizedBox(
        width: 20,
      ),
      Text(data),
      const SizedBox(
        width: 20,
      ),
      const Expanded(child: Divider()),
      const SizedBox(
        width: 20,
      ),
    ],);
  }
}
