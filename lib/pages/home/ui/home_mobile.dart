part of 'home_view.dart';

class _HomeMobile extends StatelessWidget {
  const _HomeMobile({
    Key? key,
    required this.keyForm,
    required this.passwordCtrl,
  }) : super(key: key);

  final GlobalKey<FormState> keyForm;
  final TextEditingController passwordCtrl;

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final HomeViewModel viewModel = context.watch<HomeViewModel>();

    final List<Map<String, String>> items = <Map<String, String>>[
      <String, String>{
        'nickname': 'Bayron',
        'stars': '182',
        'value1': '25000',
        'value2': '1.5',
        'banco': 'Nequi',
        'time' : '3h'
      },
      <String, String>{
        'nickname': 'San Carlos',
        'stars': '112',
        'value1': '11002000',
        'value2': '1.3',
        'banco': 'Davivienda',
    'time' : '2d'
      },
      <String, String>{
        'nickname': 'Camilos',
        'stars': '302',
        'value1': '124000',
        'value2': '1.6',
        'banco': 'PSE',
        'time':'2h'
      },
      <String, String>{
        'nickname': 'Sandra',
        'stars': '102',
        'value1': '1200000',
        'value2': '2.0',
        'banco': 'Nequi',
        'time' : '3d'
      },
      <String, String>{
        'nickname': 'Camilos',
        'stars': '32',
        'value1': '1204000',
        'value2': '1.9',
        'banco': 'Bancolombia',
        'time' : '1h'
      },
      <String, String>{
        'nickname': 'Diego',
        'stars': '112',
        'value1': '129400',
        'value2': '1.5',
        'banco': 'MercadoPago'
        ,'time' : '3h'
      }
    ];

    return Container(
      color: LdColors.black,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                color: LdColors.blackBackground,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SvgPicture.asset(LdAssets.logo, width: 150,),
                      IconButton(
                        onPressed: () => viewModel.goLogin(context),
                        icon: const Icon(
                          Icons.account_circle,
                          color: LdColors.white,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  // backgroundColor: Colors.blueAccent,
                  appBar: PreferredSize(
                    preferredSize:
                        const Size.fromHeight(kMinInteractiveDimension + 1),
                    child: Container(
                      color: LdColors.blackBackground,
                      child: Column(
                        children: <Widget>[
                          TabBar(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            indicatorColor: LdColors.orangePrimary,
                            indicatorWeight: 3,
                            labelColor: Colors.grey,
                            unselectedLabelColor: Colors.red,
                            tabs: <Widget>[
                              Tab(
                                child: Text(
                                  'Comprar',
                                  style: textTheme.textYellow
                                      .copyWith(fontWeight: FontWeight.w400, color: LdColors.orangePrimary),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Vender',
                                  style: textTheme.textYellow
                                      .copyWith(fontWeight: FontWeight.w400, color: LdColors.orangePrimary),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  body: TabBarView(
                    children: <Widget>[
                      RefreshIndicator(
                        onRefresh: () async {
                          // keyRefresh.currentState?.show(atTop: false);
                          await Future<Duration>.delayed(
                              const Duration(seconds: 1),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          child: Column(
                            children: <Widget>[
                              OptionsFilterRow(textTheme: textTheme, quantityFilter: 2,),
                              const Divider(
                                height: 8,
                                color: LdColors.gray,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Ofertas para comprar',
                                  textAlign: TextAlign.center,
                                  style: textTheme.textBlack
                                      .copyWith(fontWeight: FontWeight.w500, color: LdColors.orangePrimary),
                                ),
                              ),
                              Expanded(
                                child: ListView.separated(

                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const SizedBox(
                                      height: 8,
                                    );
                                  },
                                  // controller: _scrollController,
                                  itemCount: items.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return CardBuyAndSell(
                                        index: index,
                                        items: items,
                                        textTheme: textTheme,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      RefreshIndicator(
                        onRefresh: () async {
                          // keyRefresh.currentState?.show(atTop: false);
                          await Future<Duration>.delayed(
                            const Duration(seconds: 1),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10, top: 18),
                                child: OptionsFilterRow(
                                  textTheme: textTheme,
                                  quantityFilter: 1,
                                ),
                              ),
                              const Divider(
                                height: 8,
                                color: LdColors.gray,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Ofertas para Vender',
                                  textAlign: TextAlign.center,
                                  style: textTheme.textBigBlack
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                              ),
                              Expanded(
                                child: ListView.separated(
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const SizedBox(
                                      height: 8,
                                    );
                                  },
                                  // controller: _scrollController,
                                  shrinkWrap: true,
                                  itemCount: items.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return CardBuyAndSell(
                                        index: index,
                                        items: items,
                                        textTheme: textTheme,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
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
            style:
                textTheme.textSmallBlack,
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
                  .copyWith(fontWeight: FontWeight.w600,fontSize: 12),
            ),
          ],
        )
      ],
    );
  }
}
