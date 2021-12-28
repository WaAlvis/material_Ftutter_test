import 'package:flutter/material.dart';
import 'package:localdaily/pages/register/register_view_model.dart';

import 'package:localdaily/widgets/primary_button.dart';
import 'package:localdaily/widgets/input_text_custom.dart';

class FirstStepRegister extends StatelessWidget {
  const FirstStepRegister({
    required this.keyFirstForm,
    required this.emailCtrl,
    required this.viewModel,
    //required this.textTheme,
    Key? key,
  }) : super(key: key);
  final GlobalKey<FormState> keyFirstForm;
  final TextEditingController emailCtrl;
  final RegisterViewModel viewModel;

  //final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    // final RegisterViewModel viewModel = context.watch<RegisterViewModel>();

    final TextTheme textTheme = Theme
        .of(context)
        .textTheme;
    final Size size = MediaQuery
        .of(context)
        .size;

    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Form(
          key: keyFirstForm,
          child: Column(
            children: <Widget>[
              InputTextCustom(
                  'Correo electronico',
                  controller: emailCtrl,
                  hintText: 'ejemplo@correo.com',
                  validator: (String? email) => viewModel.validatorEmail(context, email)
                  //     (String? value) {
                  //   if (value == null || value.isEmpty) {
                  //     return '* Campo obligatorio';
                  //   }
                  //   return null;
                  // }
                  // ,
              ),
              const SizedBox(
                height: 20,
              ),
              const Spacer(),
              PrimaryButtonCustom(
                'Ingresar',
                onPressed: () {
                  if (keyFirstForm.currentState!.validate()) {
                    // Si el formulario es válido, muestre un snackbar. En el mundo real, a menudo
                    // desea llamar a un servidor o guardar la información en una base de datos
                    viewModel.goValidateEmail(context, emailCtrl.text);
                  }
                }

              ),
            ],
          ),
        ),
      ),
    );
  }
}
