part of 'change_password_view.dart';

class ChangePasswordMobile extends StatelessWidget {
  const ChangePasswordMobile({
    Key? key,
    required this.keyForm,
    required this.currentPswCtrl,
    required this.newPswCtrl,
    required this.againPswCtrl,

    // required this.scrollCtrl,
  }) : super(key: key);
  final GlobalKey<FormState> keyForm;

  final TextEditingController currentPswCtrl;
  final TextEditingController newPswCtrl;
  final TextEditingController againPswCtrl;

  @override
  Widget build(BuildContext context) {
    final ChangePasswordViewModel viewModel =
        context.watch<ChangePasswordViewModel>();
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    const double hAppbar = 150;
    final double hBody = size.height - hAppbar;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: LdColors.blackBackground,
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
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 40,
              ),
              width: size.width,
              constraints: BoxConstraints(minHeight: hBody),
              decoration: const BoxDecoration(
                color: LdColors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                          const SizedBox(height: 40,),
                        InputTextCustom(
                          'Contraseña *',
                          hintText: '8+ digitos',
                          controller: currentPswCtrl,
                          onChange: (String psw) {
                            viewModel.changePassword(psw);
                            viewModel.isPasswordValid(psw);
                          },
                          changeFillWith: !viewModel.status.isPasswordFieldEmpty,
                          textInputAction: TextInputAction.next,
                          obscureText: viewModel.status.hidePass,
                          validator: (_) => viewModel.validatorPasswords(
                            newPswCtrl.text,
                            againPswCtrl.text,
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
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum Language { spanish, english }
