import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localdaily/pages/register/register_view_model.dart';
import 'package:localdaily/widgets/input_text_custom.dart';
import 'package:localdaily/widgets/primary_button.dart';

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

    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Form(
          key: keyFirstForm,
          child: Column(
            children: <Widget>[
              InputTextCustom(
                'Correo electronico',
                hintText: 'ejemplo@correo.com',
                controller: emailCtrl,
                onChange: (String value) => viewModel.changeEmail(value),
                changeFillWith: !viewModel.status.isEmailFieldEmpty,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.send,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.deny(
                    RegExp(r'[ ]'),
                  ),
                ],
                onFieldSubmitted: (_) {
                  if (keyFirstForm.currentState!.validate()) {
                    viewModel.goNextStep(
                      context,
                      email: emailCtrl.text,
                      currentStep: 1,
                    );
                  }
                },
                validator: (String? email) =>
                    viewModel.validatorEmail(context, email),
              ),
              const SizedBox(height: 20),
              const Spacer(),
              PrimaryButtonCustom(
                'Ingresar',
                onPressed: () {
                  if (keyFirstForm.currentState!.validate()) {
                    viewModel.goNextStep(
                      context,
                      email: emailCtrl.text,
                      currentStep: 1,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
