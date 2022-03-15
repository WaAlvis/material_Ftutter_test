part of '../../../home_view.dart';

class OperationsOffersTab extends StatelessWidget {
  const OperationsOffersTab({
    Key? key,
    required this.viewModel,
    required this.textTheme,
    required this.hAppbar,
  }) : super(key: key);

  final HomeViewModel viewModel;
  final TextTheme textTheme;
  final double hAppbar;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
                    onTap: (int index) {
                      viewModel.swapType(
                        context,
                        index == 0 ? TypeOffer.buy : TypeOffer.sell,
                        dataUserProvider.getDataUserLogged?.id ?? '',
                      );
                    },
                    tabs: <Widget>[
                      Tab(
                        child: Text(
                          'Compras',
                          style: textTheme.textYellow.copyWith(
                            fontWeight: FontWeight.w400,
                            color: LdColors.orangePrimary,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Ventas',
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
                  ListOperationsOffers(
                    '',
                    textTheme: textTheme,
                    items: viewModel.status.operationBuyData.data,
                    viewModel: viewModel,
                  ),
                  ListOperationsOffers(
                    '',
                    textTheme: textTheme,
                    items: viewModel.status.operationSaleData.data,
                    viewModel: viewModel,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
