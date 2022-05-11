part of 'change_password_view.dart';

class ChangePasswordMobile extends StatelessWidget {
  const ChangePasswordMobile({
    Key? key,
    required this.keyForm,
    required this.currentPswCtrl,
    required this.newPswCtrl,
    required this.againNewPswCtrl,

    // required this.scrollCtrl,
  }) : super(key: key);
  final GlobalKey<FormState> keyForm;

  final TextEditingController currentPswCtrl;
  final TextEditingController newPswCtrl;
  final TextEditingController againNewPswCtrl;

  @override
  Widget build(BuildContext context) {
    final ChangePasswordViewModel viewModel =
        context.watch<ChangePasswordViewModel>();
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    final DataUserProvider dataUserProvider = context.read<DataUserProvider>();

    const double hAppbar = 150;
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
        body: SingleChildScrollView(
          child: Column(
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
                        padding: const EdgeInsets.only(
                          left: 12.0,
                          right: 12.0,
                          top: 30,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            IconButton(
                              onPressed: () => viewModel.goBack(context),
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: LdColors.white,
                              ),
                            ),
                            Text(
                              'Cambiar contraseña',
                              style: textTheme.textBigWhite,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.transparent,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 30,
                ),
                width: size.width,
                constraints: BoxConstraints(minHeight: hBody),
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
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              'Cambiar Contraseña',
                              style: textTheme.textBlack.copyWith(
                                // color: LdColors.orangeWarning,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Ingresa una contraseña segura y fácil de recordar',
                              style: textTheme.textBlack.copyWith(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      InputTextCustom(
                        'Contraseña actual*',
                        hintText: '8+ digitos',
                        controller: currentPswCtrl,
                        onChange: (String psw) {
                          viewModel.changeCurrentPsw(psw);
                        },
                        changeFillWith: !viewModel.status.isCurrentPswFieldEmpty,
                        textInputAction: TextInputAction.next,
                        obscureText: viewModel.status.hidePass,
                        validator: (_) => viewModel.validatorCurrentPswNotEmpty(
                          currentPswCtrl.text,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () => viewModel.hidePassword(),
                          child: Icon(
                            viewModel.status.hidePass
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: LdColors.blackBackground,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      InputTextCustom(
                        'Nueva Contraseña *',
                        hintText: '8+ digitos',
                        controller: newPswCtrl,
                        onChange: (String psw) {
                          viewModel.changeNewPsw(psw);
                          viewModel.isPasswordValid(psw);
                        },
                        changeFillWith: !viewModel.status.isNewPswFieldEmpty,
                        textInputAction: TextInputAction.next,
                        obscureText: viewModel.status.hidePass,
                        validator: (_) => viewModel.validatorPasswords(
                          newPswCtrl.text,
                          againNewPswCtrl.text,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () => viewModel.hidePassword(),
                          child: Icon(
                            viewModel.status.hidePass
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: LdColors.blackBackground,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      InputTextCustom(
                        'Repetir nueva contraseña*',
                        hintText: '8+ digitos',
                        controller: againNewPswCtrl,
                        onChange: (String psw) {
                          viewModel.changeAgainNewPsw(psw);
                        },
                        changeFillWith: !viewModel.status.isAgainNewPswFieldEmpty,
                        textInputAction: TextInputAction.next,
                        obscureText: viewModel.status.hidePass,
                        suffixIcon: GestureDetector(
                          onTap: () => viewModel.hidePassword(),
                          child: Icon(
                            viewModel.status.hidePass
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: LdColors.blackBackground,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ListChecksRequiredPsw(
                        context,
                        textTheme,
                        hasSpecialCharStatus: viewModel.status.hasSpecialChar,
                        hasMore8CharsStatus: viewModel.status.hasMore8Chars,
                        hasUpperLetterStatus: viewModel.status.hasUpperLetter,
                        hasLowerLetterStatus: viewModel.status.hasLowerLetter,
                        hasNumberCharStatus: viewModel.status.hasNumberChar,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      PrimaryButtonCustom(
                        'Continuar',
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (keyForm.currentState!.validate()) {
                            viewModel.changePsw(
                              context,
                              dataUserProvider.getDataUserLogged!.id,
                              currentPswCtrl.text,
                              newPswCtrl.text,
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum Language { spanish, english }
