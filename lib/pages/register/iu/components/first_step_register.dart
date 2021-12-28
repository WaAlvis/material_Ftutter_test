import 'package:flutter/material.dart';
import 'package:localdaily/pages/register/register_view_model.dart';

import 'package:localdaily/widgets/primary_button.dart';
import 'package:localdaily/widgets/input_text_custom.dart';

class FirstStepRegister extends StatelessWidget {
  const FirstStepRegister({
    required this.emailCtrl,
    required this.viewModel,
    //required this.textTheme,
    Key? key,
  }) : super(key: key);
  final TextEditingController emailCtrl;
  final RegisterViewModel viewModel;

  //final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    // final RegisterViewModel viewModel = context.watch<RegisterViewModel>();

    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          children: <Widget>[
            InputTextCustom(
              'Correo electronico',
              controller: emailCtrl,
              hintText: 'ejemplo@correo.com',
            ),
            const SizedBox(
              height: 20,
            ),
            const Spacer(),
            PrimaryButtonCustom(
              'Ingresar',
              onPressed: () =>
                  viewModel.goValidateEmail(context, emailCtrl.text),
            ),
          ],
        ),
      ),
    );
  }
}
