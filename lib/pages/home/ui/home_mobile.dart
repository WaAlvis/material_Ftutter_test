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

    final List<Map<String, String>> items = <Map<String, String>>[
      <String, String>{
        'nickname': 'Bayron',
        'stars': '182',
        'value1': '25000',
        'value2': '830000',
        'banco': 'Nequi'
      },
      {
        'nickname': 'San Carlos',
        'stars': '112',
        'value1': '11002000',
        'value2': '875000',
        'banco': 'Davivienda'
      },
      {
        'nickname': 'Camilos',
        'stars': '302',
        'value1': '124000',
        'value2': '890000',
        'banco': 'PSE'
      },
      {
        'nickname': 'Sandra',
        'stars': '102',
        'value1': '1200000',
        'value2': '845000',
        'banco': 'Nequi'
      },
      {
        'nickname': 'Camilos',
        'stars': '32',
        'value1': '1204000',
        'value2': '830000',
        'banco': 'Bancolombia'
      },
      {
        'nickname': 'Diego',
        'stars': '112',
        'value1': '129400',
        'value2': '865000',
        'banco': 'MercadoPago'
      }
    ];
    return Container(
      color: LdColors.blueDark,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                color: LdColors.blueDark,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        child: Image.asset('lib/assets/images/logo.png',),
                        alignment: Alignment.centerLeft,
                      ),
                      const Icon(
                        Icons.account_circle,
                        color: LdColors.white,
                        size: 32,
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
                      color: LdColors.blueDark,
                      child: Column(
                        children: <Widget>[
                          TabBar(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            indicatorColor: Colors.yellow,
                            indicatorWeight: 3,
                            labelColor: Colors.grey,
                            unselectedLabelColor: Colors.red,
                            tabs: <Widget>[
                              Tab(
                                child: Text(
                                  'Compra',
                                  style: textTheme.textYellow
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Vende',
                                  style: textTheme.textYellow
                                      .copyWith(fontWeight: FontWeight.w500),
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
                            children: [
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
                              const Duration(seconds: 1));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          child: Column(
                            children:  [
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, top: 18),
                                  child: OptionsFilterRow(textTheme: textTheme, quantityFilter: 1,
                                  ),
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
        children: [
          const SizedBox(
            width: 5,
          ),
          const Icon(Icons.filter_alt_outlined),
          Text(
            'Filtros ($quantityFilter)',
            style:
                textTheme.textSmallBlack.copyWith(fontWeight: FontWeight.w600),
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
      children: [
        Text(
          title,
          style: textTheme.textSmallWhite.copyWith(fontSize: 15),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              valueMoney,
              style:
                  textTheme.textBigBlack.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              'COP/DLY',
              style: textTheme.textSmallWhite
                  .copyWith(fontWeight: FontWeight.w600),
            )
          ],
        )
      ],
    );
  }
}

