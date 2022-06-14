part of 'settings_update_view.dart';

class SettingsUpdateMobile extends StatelessWidget {
  const SettingsUpdateMobile({
    Key? key,
    required this.keyForm,

    // required this.scrollCtrl,
  }) : super(key: key);
  final GlobalKey<FormState> keyForm;

  // final ScrollController scrollCtrl;

  @override
  Widget build(BuildContext context) {
    final SettingsUpdateViewModel viewModel =
        context.watch<SettingsUpdateViewModel>();
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    const double hAppbar = 150;
    final double hBody = size.height - hAppbar;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: LdColors.blackBackground,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AppBarBigger(
              title: 'Actualizar informacion',
              hAppbar: hAppbar,
              textTheme: textTheme,
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
                    // InputTextCustom(
                    //   'Contraseña actual*',
                    //   hintText: '8+ digitos',
                    //   controller: currentPswCtrl,
                    //   onChange: (String psw) {
                    //     viewModel.changeCurrentPsw(psw);
                    //   },
                    //   changeFillWith: !viewModel.status.isCurrentPswFieldEmpty,
                    //   textInputAction: TextInputAction.next,
                    //   obscureText: viewModel.status.hidePass,
                    //   validator: (_) => viewModel.validatorCurrentPswNotEmpty(
                    //     currentPswCtrl.text,
                    //     newPswCtrl.text,
                    //   ),
                    //   suffixIcon: GestureDetector(
                    //     onTap: () => viewModel.hidePsw(),
                    //     child: Icon(
                    //       viewModel.status.hidePass
                    //           ? Icons.visibility
                    //           : Icons.visibility_off,
                    //       color: LdColors.blackBackground,
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 16),
                    // InputTextCustom(
                    //   'Nueva Contraseña *',
                    //   hintText: '8+ digitos',
                    //   controller: newPswCtrl,
                    //   onChange: (String psw) {
                    //     viewModel.changeNewPsw(psw);
                    //     viewModel.isPswValid(psw);
                    //   },
                    //   changeFillWith: !viewModel.status.isNewPswFieldEmpty,
                    //   textInputAction: TextInputAction.next,
                    //   obscureText: viewModel.status.hidePass,
                    //   validator: (_) => viewModel.validatorPsws(
                    //     newPswCtrl.text,
                    //     againNewPswCtrl.text,
                    //   ),
                    //   suffixIcon: GestureDetector(
                    //     onTap: () => viewModel.hidePsw(),
                    //     child: Icon(
                    //       viewModel.status.hidePass
                    //           ? Icons.visibility
                    //           : Icons.visibility_off,
                    //       color: LdColors.blackBackground,
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 16),
                    // InputTextCustom(
                    //   'Repetir nueva contraseña*',
                    //   hintText: '8+ digitos',
                    //   controller: againNewPswCtrl,
                    //   onChange: (String psw) {
                    //     viewModel.changeAgainNewPsw(psw);
                    //   },
                    //   changeFillWith: !viewModel.status.isAgainNewPswFieldEmpty,
                    //   textInputAction: TextInputAction.next,
                    //   obscureText: viewModel.status.hidePass,
                    //   suffixIcon: GestureDetector(
                    //     onTap: () => viewModel.hidePsw(),
                    //     child: Icon(
                    //       viewModel.status.hidePass
                    //           ? Icons.visibility
                    //           : Icons.visibility_off,
                    //       color: LdColors.blackBackground,
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 16),

                    const SizedBox(
                      height: 30,
                    ),
                    // PrimaryButtonCustom(
                    //   'Continuar',
                    //   onPressed: () {
                    //     FocusManager.instance.primaryFocus?.unfocus();
                    //     if (keyForm.currentState!.validate()) {
                    //       viewModel.changePsw(
                    //         context,
                    //         dataUserProvider.getDataUserLogged!.id,
                    //         currentPswCtrl.text,
                    //         newPswCtrl.text,
                    //       );
                    //     }
                    //   },
                    // )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dividerOptions() {
    return const Divider(
      height: 80,
      endIndent: 0,
      thickness: 1.5,
      // color: Colors.black,
    );
  }

  Widget _rowOptionSetting(
    TextTheme textTheme,
    SettingsUpdateViewModel viewModel,
    String iconLdAsset, {
    required String title,
    required String subtitle,
    double? sizeIconSvg = 30,
    bool optionLanguage = false,
    bool arrowIcon = true,
    void Function()? onTap,
  }) {
    final TextStyle styleTextLan = textTheme.textSmallBlack;
    return Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: SizedBox(
            height: sizeIconSvg,
            child: SvgPicture.asset(iconLdAsset),
          ),
          trailing: SizedBox(
            height: 40,
            child: FloatingActionButton(
              elevation: 0,
              backgroundColor:
                  arrowIcon ? LdColors.orangePrimary : Colors.transparent,
              onPressed: onTap,
              child: const Icon(
                Icons.arrow_forward_rounded,
                size: 20,
              ),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: textTheme.subtitleBlack
                    .copyWith(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 8,
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  subtitle,
                ),
              ),
            ],
          ),
        ),
        if (optionLanguage)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            // direction: Axis.horizontal,
            children: <Widget>[
              Flexible(
                child: ListTile(
                  horizontalTitleGap: 0,
                  title: Text(
                    'Español',
                    style: styleTextLan,
                    textAlign: TextAlign.end,
                  ),
                  contentPadding: EdgeInsets.zero,
                  trailing: Radio<Language>(
                    activeColor: LdColors.orangePrimary,
                    value: Language.spanish,
                    groupValue: viewModel.status.currentLanguage,
                    onChanged: (Language? value) {
                      viewModel.changeLanguage(value);
                    },
                  ),
                ),
              ),
              Flexible(
                child: ListTile(
                  contentPadding: const EdgeInsets.only(right: 50),
                  horizontalTitleGap: 0,
                  title: Text(
                    'Inglés',
                    style: styleTextLan,
                    textAlign: TextAlign.end,
                  ),
                  trailing: Radio<Language>(
                    activeColor: LdColors.orangePrimary,
                    value: Language.english,
                    groupValue: viewModel.status.currentLanguage,
                    onChanged: (Language? value) {
                      viewModel.changeLanguage(value);
                    },
                  ),
                ),
              ),
            ],
          )
      ],
    );
  }
}

enum Language { spanish, english }
