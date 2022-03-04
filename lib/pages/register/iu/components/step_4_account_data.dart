import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/pages/register/register_view_model.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/widgets/input_text_custom.dart';
import 'package:localdaily/widgets/primary_button.dart';

class Step4AccountData extends StatelessWidget {
  const Step4AccountData(
      {Key? key,
        required this.keyForm,
        required this.viewModel,
        required this.nickNameCtrl,
        required this.passwordCtrl,
        required this.confirmPassCtrl,
      })
      : super(key: key);
  final GlobalKey<FormState> keyForm;
  final RegisterViewModel viewModel;
  final TextEditingController nickNameCtrl;
  final TextEditingController passwordCtrl;
  final TextEditingController confirmPassCtrl;

  @override
  Widget build(BuildContext context) {
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
                const SizedBox(height: 20,),
                PrimaryButtonCustom(
                  'Continuar',
                  onPressed: () {
                    if (keyForm.currentState!.validate()) {
                      viewModel.continueStep_5PersonalData(nickNameCtrl.text, passwordCtrl.text,
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