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
    final DataUserProvider dataUserProvider = context.read<DataUserProvider>();
    final TextTheme textTheme = Theme.of(context).textTheme;
    final LoginViewModel viewModel = context.watch<LoginViewModel>();
    final Size size = MediaQuery.of(context).size;

    const double hAppbar = 190;
    final double hBody = size.height - hAppbar;

    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
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
                  padding: const EdgeInsets.only(
                      top: 10, left: 16, right: 16, bottom: 20),
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
                            if (viewModel.status.errorLogin)
                              WarningContainer(
                                textTheme: textTheme,
                                viewModel: viewModel,
                              )
                            else
                              const SizedBox(
                                height: 30,
                              ),
                            const SizedBox(
                              height: 22,
                            ),
                            InputTextCustom(
                              'Correo electronio *',
                              hintText: 'Ingresa correo del usuario',
                              controller: userCtrl,
                              onChange: (String value) =>
                                  viewModel.changeEmail(value),
                              changeFillWith: !viewModel.status.isEmailFieldEmpty,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.deny(
                                  RegExp(r'[ ]'),
                                ),
                              ],
                              validator: (String? email) =>
                                  viewModel.validatorEmail(email),
                            ),
                            const SizedBox(height: 20),
                            InputTextCustom(
                              'Contraseña *',
                              hintText: '8+ digitos',
                              controller: passwordCtrl,
                              changeFillWith: !viewModel.status.isPswFieldEmpty,
                              textInputAction: TextInputAction.done,
                              obscureText: viewModel.status.hidePass,
                              onChange: (String value) =>
                                  viewModel.changePsw(value),
                              // onFieldSubmitted: (_) => viewModel.goHomeForLogin(
                              //   context,
                              //   userCtrl,
                              //   passwordCtrl,
                              //   dataUserProvider,
                              //   keyForm,
                              // ),
                              validator: (String? pass) =>
                                  viewModel.validatorPass(pass),
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
                          onPressed: () => viewModel.goHomeForLogin(
                            context,
                            keyForm,
                            userCtrl,
                            passwordCtrl,
                            dataUserProvider,
                          ),
                          // onPressed: () {
                          //   if (keyForm.currentState!.validate()) {
                          //     viewModel.goHome(
                          //         context, userCtrl, passwordCtrl, dataUserProvider);
                          //   }
                          // },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WarningContainer extends StatelessWidget {
  const WarningContainer(
      {Key? key, required this.textTheme, required this.viewModel})
      : super(key: key);

  final TextTheme textTheme;
  final LoginViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 12,
      ),
      decoration: const BoxDecoration(
        color: LdColors.orangeWarning,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: size.width*0.78,
            child: Row(
              children: <Widget>[
                const Icon(
                  Icons.report_problem_outlined,
                  color: LdColors.white,
                  size: 30,
                ),
                const SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: AutoSizeText(
                    'Usuario o contraseña inválidos',
                    minFontSize: 10,
                    maxLines: 1,
                    style: textTheme.textGray.copyWith(
                      color: LdColors.white,
                    ),
                  ),
                ),
                SizedBox(width: 6,),

              ],
            ),
          ),
          GestureDetector(
            onTap: () => viewModel.closeErrMsg(),
            child: const Icon(
              Icons.close,
              color: LdColors.white,
              size: 30,
            ),
          )
        ],
      ),
    );
  }
}
