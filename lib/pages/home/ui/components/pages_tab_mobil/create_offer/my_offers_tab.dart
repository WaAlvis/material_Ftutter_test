part of '../../../home_view.dart';

class MyOffersTab extends StatelessWidget {
  const MyOffersTab({
    required this.textTheme,
    required this.hAppbar,
    required this.offerScrollBuyCtrl,
    required this.offerScrollSellCtrl,
  });

  final TextTheme textTheme;
  final double hAppbar;
  final ScrollController offerScrollBuyCtrl;
  final ScrollController offerScrollSellCtrl;

  @override
  Widget build(BuildContext context) {
    final HomeViewModel viewModel = context.watch<HomeViewModel>();
    final DataUserProvider dataUserProvider = context.read<DataUserProvider>();

    return DefaultTabController(
      length: 2,
      child: Container(
        color: LdColors.white,
        child: Column(
          children: <Widget>[
            AppbarCircles(
              hAppbar: hAppbar,
              content: Column(
                children: <TabBar>[
                  TabBar(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    indicatorColor: LdColors.orangePrimary,
                    indicatorWeight: 3,
                    labelColor: Colors.grey,
                    onTap: (int tab) {
                      viewModel.swapType(
                        context,
                        tab == 0 ? TypeOffer.buy : TypeOffer.sell,
                        dataUserProvider.getDataUserLogged?.id ?? '',
                      );
                    },
                    tabs: <Widget>[
                      Tab(
                        child: Text(
                          'Para comprar',
                          style: textTheme.textYellow.copyWith(
                            fontWeight: FontWeight.w400,
                            color: LdColors.orangePrimary,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Para vender',
                          style: textTheme.textYellow.copyWith(
                            fontWeight: FontWeight.w400,
                            color: LdColors.orangePrimary,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  ListMyOffersSale(
                    textTheme: textTheme,
                    userId: dataUserProvider.getDataUserLogged?.id ?? '',
                    offerScrollCtrl: offerScrollBuyCtrl,
                  ),
                  ListMyOffersSale(
                    textTheme: textTheme,
                    userId: dataUserProvider.getDataUserLogged?.id ?? '',
                    offerScrollCtrl: offerScrollSellCtrl,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
