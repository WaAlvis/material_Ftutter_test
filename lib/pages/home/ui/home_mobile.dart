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
    final TextTheme textTheme = Theme.of(context).textTheme;
    final HomeViewModel viewModel = context.watch<HomeViewModel>();
    final List<Data> itemsSellers = viewModel.status.sellersDataHome.data;
    final List<Data> itemsBuyers = viewModel.status.buyersDataHome.data;

    List<Widget> _pages = <Widget>[
      MainOffertsTab(
          viewModel: viewModel,
          textTheme: textTheme,
          itemsBuyers: itemsBuyers,
          itemsSellers: itemsSellers),
      const Center(
        child: Text(
          'Operaciones',
        ),
      ),

      MyOffertsTab(
        viewModel: viewModel,
        textTheme: textTheme,
        listBanks: [],
      ),

      const Center(
        child: Text(
          'Perfil',
        ),
      ),
      // Camera page
      // Chats page
    ];

    return Scaffold(
      // backgroundColor: LdColors.white,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(40)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: LdColors.grayLight,
              blurRadius: 18,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(40),
            topLeft: Radius.circular(40),
          ),
          child: BottomNavigationBar(
            unselectedItemColor: LdColors.blackText,
            currentIndex: viewModel.status.indexTab,
            selectedItemColor: LdColors.orangePrimary,
            onTap: viewModel.onItemTapped,
            elevation: 10,
            iconSize: 30,
            showUnselectedLabels: true,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_rounded,
                ),
                label: 'Inicio',
                backgroundColor: LdColors.white,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.library_add_check_outlined,
                ),
                label: 'operaciones',
                backgroundColor: LdColors.white,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.store_outlined,
                ),
                label: 'Mis ofertas',
                backgroundColor: LdColors.white,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_outlined,
                ),
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
  //mover a mainoffert Home
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
