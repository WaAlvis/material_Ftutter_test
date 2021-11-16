part of 'personal_info_register_view.dart';

class _PersonalInfoRegisterMobile extends StatelessWidget {
  const _PersonalInfoRegisterMobile({
    Key? key,
    required this.keyForm,
    required this.passwordCtrl,
  }) : super(key: key);

  final GlobalKey<FormState> keyForm;
  final TextEditingController passwordCtrl;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final PersonalInfoRegisterViewModel viewModel =
        context.watch<PersonalInfoRegisterViewModel>();
    final Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            color: LdColors.blackBackground,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Informacion de la cuenta',
                  style: textTheme.textBigWhite,
                ),
                const SizedBox(height: 12),
                Text(
                  'Escribe la informacion de ingreso a tu cuenta',
                  style:
                      textTheme.textSmallWhite.copyWith(color: LdColors.grayBg),
                ),
              ],
            ),
          ),
        ),
        Flexible(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  InputTextCustom(
                    'Nombre de usuario *',
                    textTheme: textTheme,
                    hintText: 'Ingresa tu usuario',
                    suffixIcon: const Icon(
                      Icons.check_box,
                      color: LdColors.blackBackground,
                    ),
                  ),
                  const SizedBox(height: 16),
                  InputTextCustom(
                    'Contraseña *',
                    textTheme: textTheme,
                    hintText: '8+ digitos',
                    obscureText: true,
                    suffixIcon: const Icon(
                      Icons.visibility_off,
                      color: LdColors.blackBackground,
                    ),
                  ),
                  const SizedBox(height: 16),
                  InputTextCustom(
                    'Confirmar contraseña *',
                    textTheme: textTheme,
                    hintText: '8+ digitos',
                    obscureText: true,
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
                  Container(
                    height: 200,
                    child: Column(
                      children: [
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
                    'Ingresar',
                    onPressed: () => viewModel.goHome(context),
                  ),
                ],
              ),
            ))
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
        contentPadding: EdgeInsets.all(0),
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
