import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_colors.dart';
//  'package:localdaily/pages/register/iu/3personal_info_register/personal_info_register_view.dart';
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
          child: Column(
            children: <Widget>[
              InputTextCustom(
                'Primer nombre  *',
                controller: firstNameCtrl,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                ],
                hintText: 'Ingresa tu primer nombre',
              ),
              const SizedBox(height: 16),
              InputTextCustom(
                'Segundo nombre  *',
                controller: secondNameCtrl,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                ],
                hintText: 'Ingresa tu segundo nombre',
              ),
              const SizedBox(height: 16),
              InputTextCustom(
                'Primer apellido  *',
                controller: firstLastNameCtrl,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                ],
                hintText: 'Ingresa tu primer apellido',
              ),
              const SizedBox(height: 16),
              InputTextCustom(
                'Segundo apellido  *',
                controller: secondLastNameCtrl,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                ],
                hintText: 'Ingresa tu segundo apellido',
              ),
              const SizedBox(height: 16),
              InputTextCustom(
                'Nombre de usuario  *',
                controller: nickNameCtrl,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.deny(RegExp(r'[ ]')),
                ],
                hintText: 'Ingresa tu Nickname ',
              ),
              const SizedBox(height: 16),
              InputTextCustom(
                'Celular  *',
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                keyboardType: TextInputType.number,
                controller: phoneCtrl,
                hintText: 'Ingresa tu celular',
              ),

              const SizedBox(height: 16),
              InputTextCustom(
                'Fecha de nacimiento  *',
                keyboardType: TextInputType.none,
                controller: viewModel.status.dateBirthCtrl,
                hintText: 'Ingresa tu fecha de nacimiento',
                onTap: () => viewModel.setDateBirth(context)
              ),
              const SizedBox(height: 16),
              InputTextCustom(
                'Contraseña *',
                controller: passwordCtrl,
                hintText: '8+ digitos',
                suffixIcon: const Icon(
                  Icons.visibility_off,
                  color: LdColors.blackBackground,
                ),
              ),
              const SizedBox(height: 16),
              InputTextCustom(
                'Confirmar contraseña *',
                controller: confirmPassCtrl,
                hintText: '8+ digitos',
                suffixIcon: const Icon(
                  Icons.visibility_off,
                  color: LdColors.blackBackground,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Requeriminetos minimos de la contraseña:',
                style: textTheme.textSmallBlack,
              ),
              const SizedBox(height: 10),
              // SizedBox(
              //   height: 200,
              //   child: Column(
              //     children: <Widget>[
              //       CheckTileBoxCustom(
              //         '8+ caracteres',
              //         textTheme: textTheme,
              //         value: true,
              //       ),
              //       CheckTileBoxCustom(
              //         '1 Numero',
              //         textTheme: textTheme,
              //         value: true,
              //       ),
              //       CheckTileBoxCustom(
              //         '1 Mayuscula',
              //         textTheme: textTheme,
              //         value: true,
              //       ),
              //       CheckTileBoxCustom(
              //         '1 Minuscula',
              //         textTheme: textTheme,
              //         value: false,
              //       ),
              //       CheckTileBoxCustom(
              //         '1 caracter especial',
              //         textTheme: textTheme,
              //         value: false,
              //       ),
              //     ],
              //   ),
              // ),
              PrimaryButtonCustom(
                'Registrar',
                onPressed: () {
                  // if (keyForm.currentState!.validate()) {
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
                  // }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
