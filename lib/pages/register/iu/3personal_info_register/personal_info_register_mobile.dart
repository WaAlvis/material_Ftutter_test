part of 'personal_info_register_view.dart';

class _PersonalInfoRegisterMobile extends StatelessWidget {
  const _PersonalInfoRegisterMobile({
    Key? key,
    required this.keyForm,
    required this.nickNameCtrl,
    required this.firstNameCtrl,
    required this.firstLastNameCtrl,
    required this.secondNameCtrl,
    required this.secondLastNameCtrl,
    required this.phoneCtrl,
    required this.emailCtrl,
    required this.dateBirthCtrl,
    required this.passwordCtrl,
    required this.confirrmPassCtrl,
  }) : super(key: key);

  final GlobalKey<FormState> keyForm;
  final TextEditingController nickNameCtrl;
  final TextEditingController firstNameCtrl;
  final TextEditingController firstLastNameCtrl;
  final TextEditingController secondNameCtrl;
  final TextEditingController secondLastNameCtrl;
  final TextEditingController phoneCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController dateBirthCtrl;
  final TextEditingController passwordCtrl;
  final TextEditingController confirrmPassCtrl;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final RegisterViewModel viewModel = context.watch<RegisterViewModel>();
    final Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Flexible(
        //   child: Container(
        //     padding: const EdgeInsets.symmetric(
        //       horizontal: 16,
        //     ),
        //     color: LdColors.blackBackground,
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.stretch,
        //       children: <Widget>[
        //         const SizedBox(
        //           height: 20,
        //         ),
        //         Text(
        //           'Informacion de la cuenta',
        //           style: textTheme.textBigWhite,
        //         ),
        //         const SizedBox(height: 12),
        //         Text(
        //           'Escribe la informacion de ingreso a tu cuenta',
        //           style:
        //               textTheme.textSmallWhite.copyWith(color: LdColors.grayBg),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        Flexible(
          flex: 5,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Form(
              key: keyForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  InputTextCustom(
                    'Primer nombre  *',
                    controller: firstNameCtrl,
                    style: textTheme.textSmallBlack,
                    hintText: 'Ingresa tu primer nombre',
                  ),
                  const SizedBox(height: 16),
                  InputTextCustom(
                    'Segundo nombre  *',
                    controller: secondNameCtrl,
                    style: textTheme.textSmallBlack,
                    hintText: 'Ingresa tu segundo nombre',
                  ),
                  const SizedBox(height: 16),
                  InputTextCustom(
                    'Primer apellido  *',
                    controller: firstLastNameCtrl,
                    style: textTheme.textSmallBlack,
                    hintText: 'Ingresa tu primer apellido',
                  ),
                  const SizedBox(height: 16),
                  InputTextCustom(
                    'Segundo apellido  *',
                    controller: secondLastNameCtrl,
                    style: textTheme.textSmallBlack,
                    hintText: 'Ingresa tu segundo apellido',
                  ),
                  const SizedBox(height: 16),
                  InputTextCustom(
                    'Nombre de usuario  *',
                    controller: nickNameCtrl,
                    style: textTheme.textSmallBlack,
                    hintText: 'Ingresa tu Nickname ',
                  ),
                  const SizedBox(height: 16),
                  InputTextCustom(
                    'Celular  *',
                    controller: phoneCtrl,
                    style: textTheme.textSmallBlack,
                    hintText: 'Ingresa tu celular',
                  ),
                  const SizedBox(height: 16),
                  InputTextCustom(
                    'Correo electronico  *',
                    controller: emailCtrl,
                    style: textTheme.textSmallBlack,
                    hintText: 'Ingresa tu Email',
                  ),
                  const SizedBox(height: 16),
                  InputTextCustom(
                    'Fecha de nacimiento  *',
                    controller: dateBirthCtrl,
                    style: textTheme.textSmallBlack,
                    hintText: 'Ingresa tu fecha de nacimiento',
                  ),
                  const SizedBox(height: 16),
                  InputTextCustom(
                    'Contraseña *',
                    controller: passwordCtrl,
                    style: textTheme.textSmallBlack,
                    hintText: '8+ digitos',
                    suffixIcon: const Icon(
                      Icons.visibility_off,
                      color: LdColors.blackBackground,
                    ),
                  ),
                  const SizedBox(height: 16),
                  InputTextCustom(
                    'Confirmar contraseña *',
                    controller: confirrmPassCtrl,
                    style: textTheme.textSmallBlack,
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
                  SizedBox(
                    height: 200,
                    child: Column(
                      children: <Widget>[
                        CheckTileBoxCustom(
                          '8+ caracteres',
                          textTheme: textTheme,
                          value: true,
                        ),
                        CheckTileBoxCustom(
                          '1 Numero',
                          textTheme: textTheme,
                          value: true,
                        ),
                        CheckTileBoxCustom(
                          '1 Mayuscula',
                          textTheme: textTheme,
                          value: true,
                        ),
                        CheckTileBoxCustom(
                          '1 Minuscula',
                          textTheme: textTheme,
                          value: false,
                        ),
                        CheckTileBoxCustom(
                          '1 caracter especial',
                          textTheme: textTheme,
                          value: false,
                        ),
                      ],
                    ),
                  ),
                  PrimaryButton(
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
                          emailCtrl: emailCtrl,
                          dateBirthCtrl: dateBirthCtrl,
                          passwordCtrl: passwordCtrl,
                          confirrmPassCtrl: confirrmPassCtrl,
                        );
                      // }
                    },
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class CheckTileBoxCustom extends StatelessWidget {
  const CheckTileBoxCustom(
    this.data, {
    Key? key,
    required this.value,
    required this.textTheme,
  }) : super(key: key);
  final String data;
  final bool value;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28.0,
      child: CheckboxListTile(
        title: Text(
          data,
          style: textTheme.textSmallBlack,
        ),
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: (bool? value) {},
        value: value,
        activeColor: LdColors.orangePrimary,
      ),
    );
  }
}
