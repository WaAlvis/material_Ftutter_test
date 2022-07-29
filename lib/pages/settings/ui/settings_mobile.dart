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
          AppBarBigger(
            title: 'Ajustes',
            hAppbar: hAppbar,
            textTheme: textTheme,
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
                    iconLdAsset: LdAssets.pswBlack,
                    onTap: () => viewModel.goChangePsw(context),
                    title: 'Contraseña',
                    subtitle: 'Cambia tu contraseña de acceso.',
                    sizeIconSvg: 42,
                  ),
                  _dividerOptions(),
                  _rowOptionSetting(
                    textTheme,
                    viewModel,
                    icon: Icons.remove_circle,
                    onTap: () => viewModel.goDeleteAccount(context),
                    title: 'Eliminar cuenta',
                    subtitle: 'Elimina de manera permanente tu cuenta de usuario.',
                    sizeIconSvg: 35,
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
    SettingsViewModel viewModel, {
      String? iconLdAsset,
      IconData? icon,
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
            child: iconLdAsset != null
              ? SvgPicture.asset(iconLdAsset)
              : Icon(icon, size: sizeIconSvg, color: LdColors.blackBackground,),
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
              Text(
                subtitle,
                softWrap: true,
                style: TextStyle(fontSize: 13),
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


