part of '../../../home_view.dart';

class MyOffersTab extends StatelessWidget {
  const MyOffersTab({
    required this.textTheme,
    required this.listBanks,
    required this.hAppbar,
  });

  final TextTheme textTheme;
  final List<Bank> listBanks;
  final double hAppbar;

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
                children: <Widget>[
                  ListMyOffersSale(
                    textTheme: textTheme,
                    userId: dataUserProvider.getDataUserLogged?.id ?? '',
                  ),
                  ListMyOffersSale(
                    textTheme: textTheme,
                    userId: dataUserProvider.getDataUserLogged?.id ?? '',
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
