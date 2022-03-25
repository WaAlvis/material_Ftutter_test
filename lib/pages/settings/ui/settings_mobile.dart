part of 'settings_view.dart';

class SettingsMobile extends StatelessWidget {
  const SettingsMobile({
    Key? key,
    required this.keyForm,

    // required this.scrollCtrl,
  }) : super(key: key);
  final GlobalKey<FormState> keyForm;

  // final ScrollController scrollCtrl;

  @override
  Widget build(BuildContext context) {
    final SettingsViewModel viewModel = context.watch<SettingsViewModel>();
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
                          'Ajustes',
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
                horizontal: 24,
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
                  _rowOptionSetting(
                    textTheme,
                    viewModel,
                    LdAssets.dlycopIconBlack,
                    title: 'Direccion de wallet',
                    subtitle: 'Cambia la dirección de tu wallet',
                    onTap: () {},
                  ),
                  _dividerOptions(),
                  _rowOptionSetting(
                    textTheme,
                    viewModel,
                    LdAssets.pswBlack,
                    onTap: () => viewModel.goChangePsw(context),
                    title: 'Contraseña',
                    subtitle: 'Cambia tu contraseña de acceso',
                    sizeIconSvg: 42,
                  ),
                  _dividerOptions(),
                  _rowOptionSetting(
                    textTheme,
                    viewModel,
                    LdAssets.globalBlack,
                    title: 'Idioma',
                    subtitle: 'Escoge el idioma de preferencia',
                    sizeIconSvg: 42,
                    optionLanguage: true,
                    arrowIcon: false,
                  )
                ],
              ),
            ),
          ),
        ],
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
    SettingsViewModel viewModel,
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
      children: [
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
              backgroundColor: LdColors.orangePrimary,
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
                style: textTheme.subtitleBlack.copyWith(fontSize: 18),
              ),
              const SizedBox(
                height: 8,
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Flexible(
                  child: Text(
                    subtitle,
                    // style: textTheme.textGray.copyWith(fontSize: 13),
                  ),
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
