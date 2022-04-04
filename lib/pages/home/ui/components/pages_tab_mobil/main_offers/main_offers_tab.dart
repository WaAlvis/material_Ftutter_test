part of '../../../home_view.dart';

class MainOffersTab extends StatelessWidget {
  const MainOffersTab({
    required this.textTheme,
    required this.hAppbar,
    required this.hBody,
  });

  final TextTheme textTheme;
  final double hAppbar;
  final double hBody;

  @override
  Widget build(BuildContext context) {
    final DataUserProvider dataUserProvider = context.read<DataUserProvider>();
    final HomeViewModel viewModel = context.watch<HomeViewModel>();
    final TextTheme textTheme = Theme.of(context).textTheme;

    //Alturas de el APpbar y el body

    return DefaultTabController(
      length: 2,
      child: Column(
        children: <Widget>[
          AppbarCircles(
            hAppbar: hAppbar,
            content: Column(
              children: [
                TabBar(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  indicatorColor: LdColors.orangePrimary,
                  indicatorWeight: 3,
                  labelColor: Colors.grey,
                  unselectedLabelColor: Colors.red,
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
                        'Comprar',
                        style: textTheme.textYellow.copyWith(
                          fontWeight: FontWeight.w400,
                          color: LdColors.orangePrimary,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Vender',
                        style: textTheme.textYellow.copyWith(
                          fontWeight: FontWeight.w400,
                          color: LdColors.orangePrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: <Widget>[
                ListOffersMainSwitch(
                  'Ofertas para comprar',
                  textTheme: textTheme,
                  userId: dataUserProvider.getDataUserLogged?.id ?? '',
                ),
                ListOffersMainSwitch(
                  'Ofertas para vender',
                  textTheme: textTheme,
                  userId: dataUserProvider.getDataUserLogged?.id ?? '',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
