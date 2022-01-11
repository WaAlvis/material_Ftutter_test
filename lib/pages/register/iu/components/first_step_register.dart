import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/pages/register/register_view_model.dart';
import 'package:localdaily/widgets/input_text_custom.dart';
import 'package:localdaily/widgets/primary_button.dart';

class FirstStepRegister extends StatelessWidget {
  const FirstStepRegister({
    required this.keyFirstForm,
    required this.emailCtrl,
    required this.viewModel,
    Key? key,
  }) : super(key: key);
  final GlobalKey<FormState> keyFirstForm;
  final TextEditingController emailCtrl;
  final RegisterViewModel viewModel;

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
                    viewModel.goDescValidate(emailCtrl.text);
                  }
                },
                validator: (String? email) =>
                    viewModel.validatorEmail(context, email),
              ),
              const SizedBox(height: 20),

              const Spacer(),
              Row(
                children: [

                  Checkbox(
                      value: viewModel.status.acceptTermCoditions,
                      // onChanged: (bool? value) {},
                      onChanged: (bool? newValue) => viewModel
                          .changeAcceptTermConditions(newValue: newValue!),
                      activeColor: LdColors.orangePrimary),
                  Flexible(
                    child: RichText(
                      text: TextSpan(
                        style: textTheme.bodyText1,
                        children: <InlineSpan>[
                          TextSpan(
                            text: 'Acepto los ',
                          ),
                          TextSpan(
                              text: 'Terminos y Condiciones',
                              style: TextStyle(color: LdColors.orangePrimary),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print('Terms of Service"');
                                }),
                          TextSpan(text: ' del servicio y los '),
                          TextSpan(
                              text: 'Términos de uso',
                              style: TextStyle(color: LdColors.orangePrimary),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print('Privacy Policy"');
                                }),
                          TextSpan(text: ' de la aplicacón'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              PrimaryButtonCustom(
                'Ingresar',
                onPressed: () {
                  if (keyFirstForm.currentState!.validate()) {
                    viewModel.goDescValidate(emailCtrl.text);
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

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField({
    required Widget title,
    FormFieldValidator<bool>? validator,
    bool initialValue = false,
    bool autovalidate = false,
  }) : super(
            validator: validator,
            initialValue: initialValue,
            builder: (FormFieldState<bool> state) {
              return CheckboxListTile(
                dense: state.hasError,
                title: title,
                value: state.value,
                onChanged: state.didChange,
                subtitle: state.hasError
                    ? Builder(
                        builder: (BuildContext context) => Text(
                          'Debe aceptar terminos y condiciones',
                          style: TextStyle(color: Theme.of(context).errorColor),
                        ),
                      )
                    : null,
                controlAffinity: ListTileControlAffinity.leading,
              );
            });
}
