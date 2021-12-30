part of 'login_view.dart';

class _LoginMobile extends StatelessWidget {
  const _LoginMobile({
    Key? key,
    required this.keyForm,
    required this.passwordCtrl,
    required this.userCtrl,
  }) : super(key: key);

  final GlobalKey<FormState> keyForm;
  final TextEditingController passwordCtrl;
  final TextEditingController userCtrl;

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = context.read<UserProvider>();
    final TextTheme textTheme = Theme.of(context).textTheme;
    final LoginViewModel viewModel = context.watch<LoginViewModel>();
    final Size size = MediaQuery.of(context).size;

    final double hAppbar = size.height * 0.26;
    final double hBody = size.height - hAppbar;

    final bool hidePass = true;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: LdColors.blackBackground,
      appBar: const LdAppbar(
        title: 'Iniciar sesión',
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: size.width,
            color: LdColors.blackBackground,
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: <Widget>[
                // Esto es el circulo, ideal volverlo widget
                Positioned(
                  right: 0,
                  child: SizedBox(
                    // El tamaño depende del tamaño de la pantalla
                    width: (size.width) / 4,
                    height: (size.width) / 4,
                    child: QuarterCircle(
                      circleAlignment: CircleAlignment.bottomRight,
                      color: LdColors.grayLight.withOpacity(0.05),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: SizedBox(
                    width: (size.width) * 2 / 4,
                    height: (size.width) * 2 / 4,
                    child: QuarterCircle(
                      circleAlignment: CircleAlignment.bottomRight,
                      color: LdColors.grayLight.withOpacity(0.05),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: SizedBox(
                    width: (size.width) * 3 / 4,
                    height: (size.width) * 3 / 4,
                    child: QuarterCircle(
                      circleAlignment: CircleAlignment.bottomRight,
                      color: LdColors.grayLight.withOpacity(0.05),
                    ),
                  ),
                ),
                SizedBox(
                  height: hAppbar,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          '¡Bienvenido!',
                          style: textTheme.textBigWhite.copyWith(fontSize: 30),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Inicia sesión en LocalDaily',
                          style: textTheme.textSmallWhite.copyWith(
                            color: LdColors.grayBg,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(minHeight: hBody),
                padding:
                    EdgeInsets.only(top: 60, left: 16, right: 16, bottom: 20),
                decoration: const BoxDecoration(
                  color: LdColors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25),
                  ),
                ),
                child: Form(
                  key: keyForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          InputTextCustom(
                            'Nombre de usuario *',
                            controller: userCtrl,
                            hintText: 'Ingresa tu usuario',
                            validator: (String? email) =>
                                viewModel.validatorEmail(email),
                          ),
                          const SizedBox(height: 20),
                          InputTextCustom(
                            'Contraseña *',
                            controller: passwordCtrl,
                            hintText: '8+ digitos',
                            obscureText: viewModel.status.hidePass,
                            validator: (String? pass) =>
                                viewModel.validatorPass(pass),
                            suffixIcon: GestureDetector(
                              onTap: () => viewModel.hidePassword(),
                              child: Icon(
                                viewModel.status.hidePass
                                    ?Icons.visibility_off
                                    : Icons.visibility,
                                color: LdColors.blackBackground,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () =>
                                viewModel.goRecoverPassword(context),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(50, 30),
                              alignment: Alignment.centerLeft,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Text(
                                'Olvidé mi contraseña',
                                style: textTheme.textSmallBlack.copyWith(
                                  color: LdColors.orangePrimary,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              '¿No tienes cuenta en LocalDaily?',
                              style: textTheme.textSmallBlack,
                            ),
                            TextButton(
                              onPressed: () => viewModel.goRegister(context),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(50, 30),
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
                          ],
                        ),
                      ),
                      PrimaryButtonCustom(
                        'Ingresar',
                        onPressed: () {
                          if (keyForm.currentState!.validate()) {
                            viewModel.goHome(
                                context, userCtrl, passwordCtrl, userProvider);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
