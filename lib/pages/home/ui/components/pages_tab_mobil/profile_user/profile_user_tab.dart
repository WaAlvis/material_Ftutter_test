part of '../../../home_view.dart';

class ProfileUser extends StatelessWidget {
  ProfileUser({
    required this.viewModel,
    required this.textTheme,
    required this.hAppbar,
    required this.hBody,
  });

  final HomeViewModel viewModel;
  final TextTheme textTheme;
  final double hAppbar;
  final double hBody;

  //dummy data
  final List<ProfileOption> options = <ProfileOption>[
    const ProfileOption(
      text: 'Historial',
      icon: Icons.receipt_long_outlined,
    ),
    const ProfileOption(text: 'Casos de soporte', icon: Icons.person),
    const ProfileOption(text: 'Ajuste', icon: Icons.settings_outlined),
    const ProfileOption(text: 'Salir', icon: Icons.logout),
  ];

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    final Color colorCardWhite = LdColors.white.withOpacity(0.9);

    return Scaffold(
      backgroundColor: LdColors.blackBackground,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(
            height: 90,
          ),
          const SizedBox(
            height: 30,
          ),
          _headerCardUser(context, colorCardWhite, size),
          _bodyCardUser(context, colorCardWhite),
        ],
      ),
    );
  }

  Widget _headerCardUser(
      BuildContext context, Color colorCardWhite, Size size) {
    // final DataUserProvider dataUserProvider = context.watch<DataUserProvider>();

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          top: 50,
          child: Container(
            width: size.width,
            height: 50.2,
            decoration: BoxDecoration(
              color: colorCardWhite,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
          ),
        ),
        CircleAvatar(
          radius: 50,
          backgroundColor: colorCardWhite,
          child: const Icon(
            Icons.account_circle,
            color: LdColors.blackBackground,
            size: 100,
          ),
        ),
      ],
    );
  }

  Widget _bodyCardUser(
    BuildContext context,
    Color colorCardWhite,
  ) {
    final DataUserProvider dataUserProvider = context.watch<DataUserProvider>();
    final Size size = MediaQuery.of(context).size;

    return Expanded(
      child: Container(
        height: hBody - 35,
        decoration: BoxDecoration(
          color: colorCardWhite,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              _nameEditPencil(context, colorCardWhite),
              const SizedBox(
                height: 22,
              ),
              Flexible(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      if (dataUserProvider.getDataUserLogged == null)
                        const SizedBox.shrink()
                      else
                        _balanceDlyAvailable(),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: dataUserProvider.getAddress != null &&
                                dataUserProvider.getAddress != ''
                            ? CardWalletConnect(
                                onTap: viewModel.disconnectWallet,
                                textTheme: textTheme,
                                connected: true,
                                address: dataUserProvider.getAddress,
                              )
                            : const SizedBox.shrink(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      _buttonsSocialNetwork(
                        instagram: true,
                        facebook: true,
                        twitter: true,
                      ),
                      if (dataUserProvider.getDataUserLogged == null)
                        SizedBox(
                          height: size.height*0.4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                             const  Spacer(),
                              Text(
                                'Inicia sesión para continuar',
                                style: textTheme.textBigBlack,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                'Para visualizar tu perfil y configuraciones, es necesario que inicies sesión.',
                                textAlign: TextAlign.center,
                                style: textTheme.textSmallBlack,
                              ),
                              Spacer(),
                              PrimaryButtonCustom(
                                'Iniciar sesion',
                                onPressed: ()=> viewModel.goLogin(context),
                              ),
                            ],
                          ),
                        )
                      else
                        ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: options.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              leading: Icon(
                                options[index].icon,
                                color: LdColors.orangePrimary,
                              ),
                              title: Text(
                                options[index].text,
                                style: textTheme.textBlack,
                              ),
                              dense: true,
                              onTap: () {
                                onOptionSelected(
                                  context,
                                  NavigateOption.values[index],
                                  viewModel,
                                );
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 20,
                            );
                          },
                        ),
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

  Row _buttonsSocialNetwork({
    bool instagram = false,
    bool facebook = false,
    bool twitter = false,
    double sizeIcons = 30,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        if (instagram)
          OutlinedButton(
            onPressed: () => viewModel.launchWeb(SocialNetwork.instagram),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(LdColors.orangePrimary),
              minimumSize: MaterialStateProperty.all(const Size(50, 50)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),
            child: SvgPicture.asset(
              LdAssets.socialInstagram,
              fit: BoxFit.fill,
              height: sizeIcons,
              color: LdColors.white,
            ),
          )
        else
          const SizedBox.shrink(),
        if (facebook)
          OutlinedButton(
            onPressed: () => viewModel.launchWeb(SocialNetwork.facebook),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(LdColors.orangePrimary),
              minimumSize: MaterialStateProperty.all(const Size(50, 50)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),
            child: SvgPicture.asset(
              LdAssets.socialFacebook,
              height: sizeIcons,
              color: LdColors.white,
            ),
          )
        else
          const SizedBox.shrink(),
        if (twitter)
          OutlinedButton(
            onPressed: () => viewModel.launchWeb(SocialNetwork.twitter),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(LdColors.orangePrimary),
              minimumSize: MaterialStateProperty.all(const Size(50, 50)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),
            child: SvgPicture.asset(
              LdAssets.socialTwitter,
              height: sizeIcons,
              color: LdColors.white,
            ),
          )
        else
          const SizedBox.shrink()
      ],
    );
  }

  void onOptionSelected(
    BuildContext context,
    NavigateOption opt,
    HomeViewModel viewModel,
  ) {
    switch (opt) {
      case NavigateOption.history:
        viewModel.goHistoryOperations(context);
        break;
      case NavigateOption.support:
        // TODO: Handle this case.
        break;
      case NavigateOption.settings:
        viewModel.goSettings(context);
        break;
      case NavigateOption.logout:
        viewModel.logoutUser(context);
        // TODO: Handle this case.
        break;
    }
  }

  Widget _balanceDlyAvailable() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
      decoration: BoxDecoration(
        color: LdColors.orangePrimary,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    viewModel.status.balance == -1
                        ? '-'
                        : NumberFormat.simpleCurrency(
                            decimalDigits: 0,
                            name: '',
                            locale: 'IT',
                          ).format(viewModel.status.balance),
                    style: textTheme.textBigWhite.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SvgPicture.asset(LdAssets.dlycopIconWhite)
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Saldo en Dailys',
            style: textTheme.textSmallWhite.copyWith(fontSize: 14),
          )
        ],
      ),
    );
  }

  Widget _nameEditPencil(BuildContext context, Color colorCardWhite) {
    final DataUserProvider dataUserProvider = context.watch<DataUserProvider>();

    const double sizeCircleIcon = 22;
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const CircleAvatar(
                radius: sizeCircleIcon,
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.edit,
                  color: Colors.transparent,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    viewModel.status.resultDataUser?.nickName ?? 'Sin Usuario',
                    style: textTheme.textBigBlack
                        .copyWith(fontSize: 26, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              const CircleAvatar(
                radius: sizeCircleIcon,
                backgroundColor: LdColors.orangePrimary,
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        if (dataUserProvider.getDataUserLogged == null)
          const SizedBox.shrink()
        else
          Text(
            'usuario desde el 2010',
            style: textTheme.textSmallBlack.copyWith(
              color: LdColors.gray,
              fontSize: 14,
            ),
          ),
      ],
    );
  }
}

class ProfileOption {
  final IconData icon;
  final String text;

  const ProfileOption({
    required this.text,
    required this.icon,
  });
}
