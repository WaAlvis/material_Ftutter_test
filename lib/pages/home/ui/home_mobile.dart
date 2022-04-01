part of 'home_view.dart';

class _HomeMobile extends StatelessWidget {
  const _HomeMobile({
    Key? key,
    // required this.keyForm,
    // required this.passwordCtrl,
  }) : super(key: key);

  // final GlobalKey<FormState> keyForm;
  // final TextEditingController passwordCtrl;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double hAppbar = 150;
    final double hBody = size.height - hAppbar;
    final DataUserProvider dataUserProvider = context.read<DataUserProvider>();

    final TextTheme textTheme = Theme.of(context).textTheme;
    final HomeViewModel viewModel = context.watch<HomeViewModel>();

    final List<Widget> _pages = <Widget>[
      MainOffersTab(
        textTheme: textTheme,
        hAppbar: hAppbar,
        hBody: hBody,
      ),
      OperationsOffersTab(
        viewModel: viewModel,
        textTheme: textTheme,
        hAppbar: hAppbar,
      ),
      MyOffersTab(
        textTheme: textTheme,
        listBanks: [],
        hAppbar: hAppbar,
      ),
      ProfileUser(
        viewModel: viewModel,
        textTheme: textTheme,
        hAppbar: hAppbar,
        hBody: hBody,
      ),
      // Camera page
      // Chats page
    ];

    final List<PreferredSizeWidget> _appbars = <PreferredSizeWidget>[
      LdAppbar(
        dataUserProvider: dataUserProvider.getDataUserLogged,
        goLogin: (BuildContext context) => viewModel.goLogin(context),
        // withBackIcon: false,
      ),
      LdAppbar(
        title: 'Mis operaciones',
        goLogin: (BuildContext context) => viewModel.goLogin(context),
        // withBackIcon: false,
      ),
      LdAppbar(
        title: 'Mis ofertas',
        goLogin: (BuildContext context) => viewModel.goLogin(context),
        // withBackIcon: false,
      ),
      LdAppbar(
        title: 'Perfil',
        goLogin: (BuildContext context) => viewModel.goLogin(context),
        // withBackIcon: false,
      )
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appbars.elementAt(viewModel.status.indexTab),
      floatingActionButton: viewModel.status.indexTab == 2 &&
              ((viewModel.status.myOfferBuyData.data.isNotEmpty &&
                      viewModel.status.typeOffer == TypeOffer.buy) ||
                  (viewModel.status.myOfferSaleData.data.isNotEmpty &&
                      viewModel.status.typeOffer == TypeOffer.sell))
          ? FloatingActionButton(
              backgroundColor: LdColors.orangePrimary,
              tooltip: 'Crear oferta',
              onPressed: () => viewModel.goCreateOffer(context),
              child: const Icon(Icons.add, color: LdColors.white),
            )
          : const SizedBox.shrink(),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: LdColors.grayLight,
              blurRadius: 18,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            unselectedItemColor: LdColors.blackText,
            currentIndex: viewModel.status.indexTab,
            selectedItemColor: LdColors.orangePrimary,
            onTap: (int index) {
              if (index != viewModel.status.indexTab) {
                viewModel.swapType(
                  context,
                  TypeOffer.buy,
                  dataUserProvider.getDataUserLogged?.id ?? '',
                );
              }
              viewModel.onItemTapped(index);
            },
            elevation: 10,
            iconSize: 30,
            showUnselectedLabels: true,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Inicio',
                backgroundColor: LdColors.white,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_add_check_outlined),
                activeIcon: Icon(Icons.library_add_check),
                label: 'Operaciones',
                backgroundColor: LdColors.white,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.store_outlined),
                activeIcon: Icon(Icons.store),
                label: 'Mis ofertas',
                backgroundColor: LdColors.white,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outlined),
                activeIcon: Icon(Icons.person),
                label: 'Perfil',
                backgroundColor: LdColors.white,
              ),
            ],
          ),
        ),
      ),
      body: _pages.elementAt(viewModel.status.indexTab),
    );
  }
}

class OptionsFilterRow extends StatelessWidget {
  //mover a mainoffer Home
  const OptionsFilterRow({
    Key? key,
    required this.textTheme,
    required this.quantityFilter,
  }) : super(key: key);

  final int quantityFilter;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 18),
      child: Row(
        children: <Widget>[
          const SizedBox(
            width: 5,
          ),
          const Icon(Icons.filter_alt_outlined),
          Text(
            'Filtros ($quantityFilter)',
            style: textTheme.textSmallBlack,
          )
        ],
      ),
    );
  }
}
