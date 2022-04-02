import 'package:flutter/material.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_colors.dart';

class ListChecksRequiredPsw extends StatelessWidget {
  const ListChecksRequiredPsw(
    this.context,
    this.textTheme, {
    Key? key,
    required this.hasMore8CharsStatus,
    required this.hasUpperLetterStatus,
    required this.hasLowerLetterStatus,
    required this.hasNumberCharStatus,
    required this.hasSpecialCharStatus,
  }) : super(key: key);

  final BuildContext context;
  final TextTheme textTheme;

  // final ViewModel viewModel;
  final bool hasMore8CharsStatus;
  final bool hasUpperLetterStatus;
  final bool hasLowerLetterStatus;
  final bool hasNumberCharStatus;
  final bool hasSpecialCharStatus;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            'Requeriminetos minimos de la contraseña:',
            style: textTheme.textSmallBlack,
          ),
        ),
        const SizedBox(height: 4),
        checkRowValidation(
          '8+ Caracteres',
          value: hasMore8CharsStatus,
        ),
        checkRowValidation(
          '1 Mayúscula',
          value: hasUpperLetterStatus,
        ),
        checkRowValidation(
          '1 Minúscula',
          value: hasLowerLetterStatus,
        ),
        checkRowValidation(
          '1 Número',
          value: hasNumberCharStatus,
        ),
        checkRowValidation(
          '1 Caracter especial',
          value: hasSpecialCharStatus,
        ),
      ],
    );
  }

  Row checkRowValidation(String title, {required bool? value}) {
    return Row(
      children: <Widget>[
        SizedBox(
          height: 24,
          child: Checkbox(
            activeColor: LdColors.orangePrimary,
            value: value,
            onChanged: (_) {},
          ),
        ),
        Flexible(
          child: Text(title),
        ),
      ],
    );
  }
}
