import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/pages/register/register_view_model.dart';
import 'package:localdaily/widgets/input_text_custom.dart';
import 'package:localdaily/widgets/primary_button.dart';

class FourthStepRegister extends StatelessWidget {
  const FourthStepRegister({
    Key? key,
    required this.keyForm,
    required this.nickNameCtrl,
    required this.firstNameCtrl,
    required this.firstLastNameCtrl,
    required this.secondNameCtrl,
    required this.secondLastNameCtrl,
    required this.phoneCtrl,
    required this.dateBirthCtrl,
    required this.passwordCtrl,
    required this.confirmPassCtrl,
    required this.viewModel,
  }) : super(key: key);
  final RegisterViewModel viewModel;
  final GlobalKey<FormState> keyForm;
  final TextEditingController nickNameCtrl;
  final TextEditingController firstNameCtrl;
  final TextEditingController firstLastNameCtrl;
  final TextEditingController secondNameCtrl;
  final TextEditingController secondLastNameCtrl;
  final TextEditingController phoneCtrl;
  final TextEditingController dateBirthCtrl;
  final TextEditingController passwordCtrl;
  final TextEditingController confirmPassCtrl;

  @override
  Widget build(BuildContext context) {
    // final RegisterViewModel viewModel = context.watch<RegisterViewModel>();

    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

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
                  'Primer nombre  *',
                  hintText: 'Ingresa tu primer nombre',
                  controller: firstNameCtrl,
                  onChange: (String value) => viewModel.changeFirstName(value),
                  changeFillWith: !viewModel.status.isFirstNameFieldEmpty,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  validator: (String? firstName) =>
                      viewModel.validatorNotEmpty(firstName),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                  ],
                ),
                const SizedBox(height: 16),
                InputTextCustom(
                  'Segundo nombre  *',
                  hintText: 'Ingresa tu segundo nombre',
                  onChange: (String value) => viewModel.changeSecondName(value),
                  changeFillWith: !viewModel.status.isSecondNameFieldEmpty,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  validator: (String? secondName) =>
                      viewModel.validatorNotEmpty(secondName),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                  ],
                ),
                const SizedBox(height: 16),
                InputTextCustom(
                  'Primer apellido  *',
                  hintText: 'Ingresa tu primer apellido',
                  controller: firstLastNameCtrl,
                  onChange: (String value) =>
                      viewModel.changeFirstLastName(value),
                  changeFillWith: !viewModel.status.isFirstLastNameFieldEmpty,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  validator: (String? str) => viewModel.validatorNotEmpty(str),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                  ],
                ),
                const SizedBox(height: 16),
                InputTextCustom(
                  'Segundo apellido  *',
                  hintText: 'Ingresa tu segundo apellido',
                  controller: secondLastNameCtrl,
                  onChange: (String value) =>
                      viewModel.changeSecondLastName(value),
                  changeFillWith: !viewModel.status.isSecondLastNameFieldEmpty,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  validator: (String? str) => viewModel.validatorNotEmpty(str),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                  ],
                ),
                const SizedBox(height: 16),
                InputTextCustom(
                  'Nombre de usuario  *',
                  hintText: 'Ingresa tu Nickname ',
                  controller: nickNameCtrl,
                  onChange: (String value) => viewModel.changeNickName(value),
                  changeFillWith: !viewModel.status.isNickNameFieldEmpty,
                  textInputAction: TextInputAction.next,
                  validator: (String? str) => viewModel.validatorNotEmpty(str),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.deny(RegExp(r'[ ]')),
                  ],
                ),
                const SizedBox(height: 16),
                InputTextCustom(
                  'Celular  *',
                  hintText: 'Ingresa tu celular',
                  controller: phoneCtrl,
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
                InputTextCustom('Fecha de nacimiento  *',
                    keyboardType: TextInputType.none,
                    hintText: 'Ingresa tu fecha de nacimiento',
                    controller: viewModel.status.dateBirthCtrl,
                    changeFillWith: !viewModel.status.isDateBirthFieldEmpty,
                    onTap: () => viewModel.setDateBirth(context)),
                const SizedBox(height: 16),
                InputTextCustom(
                  'Contraseña *',
                  hintText: '8+ digitos',
                  controller: passwordCtrl,
                  onChange: (String psw) {
                    viewModel.changePassword(psw);
                    viewModel.isPasswordValid(psw);
                  },
                  changeFillWith: !viewModel.status.isPasswordFieldEmpty,
                  textInputAction: TextInputAction.next,
                  obscureText: viewModel.status.hidePass,
                  validator: (_) => viewModel.validatorPasswords(
                    passwordCtrl.text,
                    confirmPassCtrl.text,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () => viewModel.hidePassword(),
                    child: Icon(
                      viewModel.status.hidePass
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: LdColors.blackBackground,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                InputTextCustom(
                  'Confirmar contraseña *',
                  hintText: '8+ digitos',
                  controller: confirmPassCtrl,
                  obscureText: viewModel.status.hidePass,
                  onChange: (String value) =>
                      viewModel.changeConfirmPass(value),
                  changeFillWith: !viewModel.status.isConfirmPassFieldEmpty,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 16),
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
                  value: viewModel.status.hasMore8Chars,
                ),
                checkRowValidation(
                  '1 Mayúscula',
                  value: viewModel.status.hasUpperLetter,
                ),
                checkRowValidation(
                  '1 Minúscula',
                  value: viewModel.status.hasLowerLetter,
                ),
                checkRowValidation(
                  '1 Número',
                  value: viewModel.status.hasNumberChar,
                ),
                checkRowValidation(
                  '1 Caracter especial',
                  value: viewModel.status.hasSpecialChar,
                ),
                const SizedBox(height: 10),
                PrimaryButtonCustom(
                  'Registrar',
                  onPressed: () {
                    if (keyForm.currentState!.validate()) {
                      viewModel.registerUser(
                        context,
                        nickNameCtrl: nickNameCtrl,
                        firstNameCtrl: firstNameCtrl,
                        firstLastNameCtrl: firstLastNameCtrl,
                        secondNameCtrl: secondNameCtrl,
                        secondLastNameCtrl: secondLastNameCtrl,
                        phoneCtrl: phoneCtrl,
                        emailRegister: viewModel.status.emailRegister,
                        dateBirthCtrl: viewModel.status.dateBirthCtrl,
                        passwordCtrl: passwordCtrl,
                        confirrmPassCtrl: confirmPassCtrl,
                      );
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
