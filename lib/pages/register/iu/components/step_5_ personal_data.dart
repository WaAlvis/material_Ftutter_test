import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/pages/register/register_view_model.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/widgets/input_text_custom.dart';
import 'package:localdaily/widgets/primary_button.dart';

class Step5PersonalData extends StatelessWidget {
  const Step5PersonalData({
    Key? key,
    required this.keyForm,
    required this.viewModel,
    required this.namesCtrl,
    required this.surnamesCtrl,
    required this.phoneCtrl,
    required this.dateBirthCtrl,
    // required this.dataUserProvider,
  }) : super(key: key);
  final GlobalKey<FormState> keyForm;
  final RegisterViewModel viewModel;
  final TextEditingController namesCtrl;
  final TextEditingController surnamesCtrl;
  final TextEditingController phoneCtrl;
  final TextEditingController dateBirthCtrl;

  // final DataUserProvider dataUserProvider;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    final int phraseLength = 0;

    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Form(
            key: keyForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                InputTextCustom(
                  'Nombres  *',
                  hintText: 'Ingresa tu primer nombre',
                  controller: namesCtrl,
                  onChange: (String value) => viewModel.changeFirstName(value),
                  changeFillWith: !viewModel.status.isFirstNameFieldEmpty,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  validator: (String? firstName) =>
                      viewModel.validatorNotEmpty(firstName),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                  ],
                ),
                const SizedBox(height: 16),
                InputTextCustom(
                  'Apellidos  *',
                  hintText: 'Ingresa tu segundo nombre',
                  controller: surnamesCtrl,
                  onChange: (String value) => viewModel.changeSecondName(value),
                  changeFillWith: !viewModel.status.isSecondNameFieldEmpty,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  validator: (String? secondName) =>
                      viewModel.validatorNotEmpty(secondName),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                  ],
                ),
                const SizedBox(height: 16),
                InputTextCustom(
                  'Fecha de nacimiento  *',
                  keyboardType: TextInputType.none,
                  hintText: 'Ingresa tu fecha de nacimiento',
                  controller: viewModel.status.dateBirthCtrl,
                  changeFillWith: !viewModel.status.isDateBirthFieldEmpty,
                  onTap: () => viewModel.setDateBirth(context),
                ),
                const SizedBox(height: 16),
                InputTextCustom(
                  'Celular  *',
                  hintText: 'Ingresa tu celular',
                  controller: phoneCtrl,
                  maxLength: 10,
                  onChange: (String value) => viewModel.changePhone(value),
                  changeFillWith: !viewModel.status.isPhoneFieldEmpty,
                  textInputAction: TextInputAction.next,
                  validator: (String? str) => viewModel.validatorNotEmpty(str),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                PrimaryButtonCustom(
                  'Continuar',
                  onPressed: () {
                    if (keyForm.currentState!.validate()) {
                      viewModel.continueStep_6RestoreWallet(
                          namesCtrl.text,
                          surnamesCtrl.text,
                          dateBirthCtrl.text,
                          phoneCtrl.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Row checkRowValidation(String title, {required bool? value}) {
//   return Row(
//     children: <Widget>[
//       SizedBox(
//         height: 24,
//         child: Checkbox(
//           activeColor: LdColors.orangePrimary,
//           value: value,
//           onChanged: (_) {},
//         ),
//       ),
//       Flexible(
//         child: Text(title),
//       ),
//     ],
//   );
// }
}
