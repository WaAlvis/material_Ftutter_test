part of 'login_view.dart';

class _LoginMobile extends StatelessWidget {
  const _LoginMobile({
    Key? key,
    required this.keyForm,
    required this.passwordCtrl,
  }) : super(key: key);

  final GlobalKey<FormState> keyForm;
  final TextEditingController passwordCtrl;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final LoginViewModel viewModel = context.watch<LoginViewModel>();
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '¡Bienvenido!',
                  style: textTheme.textBigWhite,
                ),
                const SizedBox(height: 12),
                Text(
                  'Inicia sesión en LocalDaily',
                  style:
                      textTheme.textSmallWhite.copyWith(color: LdColors.grayBg),
                ),
              ],
            ),
          ),
        ),
        Flexible(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  InputTextCustom(
                    'Nombre de usuario *',
                    textTheme: textTheme,
                    hintText: 'Ingresa tu usuario',
                  ),
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 3),
                  TextButton(
                    onPressed: () => viewModel.goRecoverPassword(context),
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(50, 30),
                        alignment: Alignment.centerLeft,
                    ),
                    child: Text(
                      'Olvidé mi contraseña',
                      style: textTheme.textSmallBlack.copyWith(
                        color: LdColors.orangePrimary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    '¿No tienes cuenta en LocalDaily?',
                    style: textTheme.textSmallBlack,
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () => viewModel.goRegister(context),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(50, 30),
                      alignment: Alignment.centerLeft,
                    ),
                    child: Text(
                      'Crear cuenta',
                      style: textTheme.textSmallBlack.copyWith(
                        color: LdColors.orangePrimary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const Spacer(),
                  PrimaryButton('Ingresar',
                      onPressed: () => viewModel.goHome(context),
                  ),
                ],
              ),
            ))
      ],
    );
  }
}

