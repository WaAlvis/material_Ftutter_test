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
    final TextTheme textTheme = Theme.of(context).textTheme;
    final LoginViewModel viewModel = context.watch<LoginViewModel>();
    final Size size = MediaQuery.of(context).size;

    final double hAppbar = size.height * 0.18;
    final double hBody = size.height - hAppbar;

    return Scaffold(
      backgroundColor: LdColors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // toolbarHeight: size.height * 0.13,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0, // 2
        title: Text(
          'Iniciar Sesion',
          style: textTheme.textWhite,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: size.width,
            color: LdColors.blackBackground,
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: <Widget>[
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
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Crear mi cuenta',
                        style: textTheme.textBigWhite,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Para continuar ingresa tu correo electronico.',
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
              ],
            ),
          ),
          Flexible(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Form(
                key: keyForm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    InputTextCustom(
                      'Nombre de usuario *',
                      controller: userCtrl,
                      hintText: 'Ingresa tu usuario',
                    ),
                    const SizedBox(height: 20),
                    InputTextCustom(
                      'Contraseña *',
                      controller: passwordCtrl,
                      hintText: '8+ digitos',
                      obscureText: false,
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
                        minimumSize: const Size(50, 30),
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
                    const Spacer(),
                    PrimaryButtonCustom(
                      'Ingresar',
                      onPressed: () {
                        if (keyForm.currentState!.validate()) {
                          viewModel.goHome(
                            context,
                            userCtrl,
                            passwordCtrl,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
