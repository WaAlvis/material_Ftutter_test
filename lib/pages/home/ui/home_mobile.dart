part of 'home_view.dart';

class _HomeMobile extends StatefulWidget {
  @override
  State<_HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<_HomeMobile>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final GlobalKey<FormState> keyFormReqDetail = GlobalKey<FormState>();

  // late StreamSubscription<HomeEffect> _effectSubscription;

  @override
  void initState() {
    final HomeViewModel viewModel = context.read<HomeViewModel>();

    tabController =
        TabController(length: 4, initialIndex: viewModel.index, vsync: this);
    tabController.addListener(() {
      context.read<HomeViewModel>().onTapTab(tabController.index);
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final HomeViewModel viewModel = context.watch<HomeViewModel>();
    final List<Data> itemsSellers = viewModel.status.sellersDataHome.data;
    final List<Data> itemsBuyers = viewModel.status.buyersDataHome.data;

    return DoubleBackToCloseApp(
      snackBar: const SnackBar(
        content: Text('Tap back again to leave'),
      ),
      child: DefaultTabController(
        
        length: 4,
        child: Scaffold(
          bottomNavigationBar: Stack(
            children: <Widget>[
              BottomAppBar(
                color: Colors.grey,
                elevation: 0,
                child: TabBar(
                  controller: tabController,
                  onTap: viewModel.onTapTab,
                  indicatorColor: LdColors.green,
                  tabs: <Widget>[
                    Tab(
                      icon: Icon(
                        Icons.home,
                        size: viewModel.status.indexTab == 0 ? 45 : 22,
                        color: viewModel.status.indexTab == 0
                            ? Colors.yellow
                            : Colors.white,
                      ),
                      child: viewModel.status.indexTab != 0
                          ? Text(
                              'i18n.home',
                              style: textTheme.textSmallWhite,
                            )
                          : const SizedBox.shrink(),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.crop,
                        size: viewModel.status.indexTab == 1 ? 45 : 22,
                        color: viewModel.status.indexTab == 1
                            ? Colors.yellow
                            : Colors.white,
                      ),
                      child: viewModel.status.indexTab != 1
                          ? Text(
                              'billetera',
                              style: textTheme.textSmallWhite,
                            )
                          : const SizedBox.shrink(),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.restore,
                        size: viewModel.status.indexTab == 2 ? 45 : 22,
                        color: viewModel.status.indexTab == 2
                            ? Colors.yellow
                            : Colors.white,
                      ),
                      child: viewModel.status.indexTab != 2
                          ? Text(
                              'Historial',
                              style: textTheme.textSmallWhite,
                            )
                          : const SizedBox.shrink(),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.person,
                        size: viewModel.status.indexTab == 3 ? 45 : 22,
                        color: viewModel.status.indexTab == 3
                            ? Colors.yellow
                            : Colors.white,
                      ),
                      child: viewModel.status.indexTab != 3
                          ? Text(
                              'Perfil',
                              style: textTheme.textSmallWhite,
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              )
            ],
          ),
          body: _buildReqDetail(viewModel, textTheme),
        ),
      ),
    );
  }

  Widget _buildReqDetail(HomeViewModel viewModel, TextTheme textTheme) {
    final Size size = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        TabBarView(
          controller: tabController,
          children: <Widget>[
            HomeScreen(
              viewModel.changeHideWallet,
              viewModel.changeHideValues,
              hideWallet: viewModel.status.hideWallet,
              hideValues: viewModel.status.hideValues,
            ),
            HistoricalScreen(),
            ProfileScreen(),
            ProfileScreen()
          ],
        ),
        // Positioned(
        //   bottom: -12,
        //   width: size.width,
        //   child: SvgPicture.asset(
        //     DlyAssets.tabBar,
        //     alignment: Alignment.bottomCenter,
        //     width: size.width,
        //   ),
        // )
      ],
    );
  }
}

class OptionsFilterRow extends StatelessWidget {
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

class InfoValueCard extends StatelessWidget {
  const InfoValueCard({
    Key? key,
    required this.textTheme,
    required this.title,
    required this.valueMoney,
  }) : super(key: key);

  final TextTheme textTheme;
  final String title;
  final String valueMoney;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: textTheme.textSmallWhite.copyWith(fontSize: 13),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              valueMoney,
              style:
                  textTheme.textBigBlack.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 8),
            Text(
              'COP/DLY',
              style: textTheme.textSmallWhite
                  .copyWith(fontWeight: FontWeight.w600, fontSize: 12),
            ),
          ],
        )
      ],
    );
  }
}

// final List<Map<String, String>> items = <Map<String, String>>[
//   <String, String>{  1111111
//     'nickname': 'Bayron',
//     'stars': '182',
//     'value1': '25000',
//     'value2': '1.5',
//     'banco': 'Nequi',
//     'time' : '3h'
//   },
//   <String, String>{
//     'nickname': 'San Carlos',
//     'stars': '112',
//     'value1': '11002000',
//     'value2': '1.3',
//     'banco': 'Davivienda',
// 'time' : '2d'
//   },
//   <String, String>{
//     'nickname': 'Camilos',
//     'stars': '302',
//     'value1': '124000',
//     'value2': '1.6',
//     'banco': 'PSE',
//     'time':'2h'
//   },
//   <String, String>{
//     'nickname': 'Sandra',
//     'stars': '102',
//     'value1': '1200000',
//     'value2': '2.0',
//     'banco': 'Nequi',
//     'time' : '3d'
//   },
//   <String, String>{
//     'nickname': 'Camilos',
//     'stars': '32',
//     'value1': '1204000',
//     'value2': '1.9',
//     'banco': 'Bancolombia',
//     'time' : '1h'
//   },
//   <String, String>{
//     'nickname': 'Diego',
//     'stars': '112',
//     'value1': '129400',
//     'value2': '1.5',
//     'banco': 'MercadoPago'
//     ,'time' : '3h'
//   }
// ];
