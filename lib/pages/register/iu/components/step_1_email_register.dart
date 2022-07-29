import 'package:checkbox_formfield/checkbox_formfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/pages/register/register_view_model.dart';
import 'package:localdaily/widgets/input_text_custom.dart';
import 'package:localdaily/widgets/primary_button.dart';
import 'package:url_launcher/url_launcher.dart';

class Step1EmailRegister extends StatelessWidget {
  const Step1EmailRegister({
    // required this.keyFirstForm,
    required this.keyForm,
    required this.emailCtrl,
    required this.viewModel,
    Key? key,
  }) : super(key: key);

  // final GlobalKey<FormState> keyFirstForm;
  final GlobalKey<FormState> keyForm;
  final TextEditingController emailCtrl;
  final RegisterViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    // final RegisterViewModel viewModel = context.watch<RegisterViewModel>();
    final TextTheme textTheme = Theme.of(context).textTheme;

    // final Size size = MediaQuery.of(context).size;

    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Form(
          key: keyForm,
          child: Column(
            children: <Widget>[
              InputTextCustom(
                'Correo electrónico',
                hintText: 'ejemplo@correo.com',
                controller: emailCtrl,
                onChange: (String value) => viewModel.changeEmail(value),
                changeFillWith: !viewModel.status.isEmailFieldEmpty,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.deny(
                    RegExp('[ ]'),
                  ),
                ],
                validator: (String? email) =>
                    viewModel.validatorEmail(context, email),
              ),
              const SizedBox(height: 20),
              const Spacer(),
              CheckboxTyC(textTheme: textTheme, viewModel: viewModel),
              PrimaryButtonCustom(
                'Enviar código de verificacion',
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (keyForm.currentState!.validate()) {
                    viewModel.continueStep_2MsjEmail(emailCtrl.text, context);
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

class CheckboxTyC extends StatelessWidget {
  const CheckboxTyC({
    Key? key,
    required this.textTheme,
    required this.viewModel,
  }) : super(key: key);

  final TextTheme textTheme;
  final RegisterViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTileFormField(
      activeColor: LdColors.orangePrimary,
      title: richTextTyC(),
      initialValue: viewModel.status.acceptTermCoditions,
      contentPadding: const EdgeInsets.only(bottom: 3),
      validator: (bool? valueCheckbox) =>
          viewModel.validatorCheckBox(valueCheck: valueCheckbox),
      // onChanged: (bool valueCheckbox) =>
      //     viewModel.changeAcceptTermConditions(newValue: viewModel.status.acceptTermCoditions),
    );
  }

  Widget richTextTyC() {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Acepto los ',
                style: textTheme.bodyText1,
              ),
              GestureDetector(
                onTap: () {
                  print('object');
                  viewModel.openTyc('https://localdly.com/tyc/');
                },
                child: Text(
                  'Terminos y Condiciones',
                  style: TextStyle(
                      color: LdColors.orangePrimary,
                      fontWeight: FontWeight.bold),
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  ' del ',
                  maxLines: 2,
                  style: textTheme.bodyText1,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'servicio y las ',
                style: textTheme.bodyText1,
              ),
              GestureDetector(
                onTap: () {
                  viewModel
                      .openTyc('https://localdly.com/politicas-de-privacidad/');
                },
                child: Text(
                  'politicas de privacidad',
                  style: TextStyle(
                      color: LdColors.orangePrimary,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    // return RichText(
    //   text: TextSpan(
    //     style: textTheme.bodyText1,
    //     children: <InlineSpan>[
    //       const TextSpan(
    //         text: 'Acepto los ',
    //       ),
    //       TextSpan(
    //           text: 'Terminos y Condiciones',
    //           style: const TextStyle(color: LdColors.orangePrimary),
    //           recognizer: TapGestureRecognizer()
    //             ..onTap = () => viewModel.openTyc('https://localdly.com/tyc/')),
    //       const TextSpan(text: ' del servicio y las '),
    //       TextSpan(
    //         text: 'politicas de privacidad',
    //         style: const TextStyle(color: LdColors.orangePrimary),
    //       ),
    //       const TextSpan(text: ' de la aplicacón'),
    //     ],
    //   ),
    // );
  }
}

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField({
    required Widget title,
    FormFieldValidator<bool>? validator,
    bool initialValue = false,
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
          },
        );
}
