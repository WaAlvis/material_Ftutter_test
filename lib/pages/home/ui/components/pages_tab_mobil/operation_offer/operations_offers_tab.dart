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
                  if (dataUserProvider.getDataUserLogged == null)
                    AdviceMessage(
                      imageName: LdAssets.loginIdentity,
                      title: 'Inicia sesión para continuar',
                      description:
                          'Para visualizar tus operaciones de compra, es necesario que inicies sesión.',
                      btnText: 'Iniciar sesión',
                      onPressed: () => viewModel.goLogin(context),
                    )
                  else
                    ListOperationsOffers(
                      textTheme: textTheme,
                      userId: dataUserProvider.getDataUserLogged?.id ?? '',
                    ),
                  if (dataUserProvider.getDataUserLogged == null)
                    AdviceMessage(
                      imageName: LdAssets.loginIdentity,
                      title: 'Inicia sesión para continuar',
                      description:
                          'Para visualizar tus operaciones de venta, es necesario que inicies sesión.',
                      btnText: 'Iniciar sesión',
                      onPressed: () => viewModel.goLogin(context),
                    )
                  else
                    ListOperationsOffers(
                      textTheme: textTheme,
                      userId: dataUserProvider.getDataUserLogged?.id ?? '',
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
