part of '../../../home_view.dart';

enum TypeOffer { buy, sell }

class MyOffersTab extends StatelessWidget {
  const MyOffersTab({
    required this.viewModel,
    required this.textTheme,
    required this.listBanks,
    required this.hAppbar,
  });

  final HomeViewModel viewModel;
  final TextTheme textTheme;
  final List<Bank> listBanks;
  final double hAppbar;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final DataUserProvider dataUserProvider = context.read<DataUserProvider>();
    //Alturas de el APpbar y el body

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
                      if (tab == 0) {
                        viewModel.swapType(
                          context,
                          TypeOffer.buy,
                          dataUserProvider.getDataUserLogged?.id ?? '',
                        );
                      }
                      if (tab == 1) {
                        viewModel.swapType(
                          context,
                          TypeOffer.sell,
                          dataUserProvider.getDataUserLogged?.id ?? '',
                        );
                      }
                    },
                    tabs: <Widget>[
                      Tab(
                        child: Text(
                          'Para comprar',
                          style: textTheme.textYellow.copyWith(
                              fontWeight: FontWeight.w400,
                              color: LdColors.orangePrimary),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Para vender',
                          style: textTheme.textYellow.copyWith(
                              fontWeight: FontWeight.w400,
                              color: LdColors.orangePrimary),
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
                  ListCreateOfferSwitch(
                    type: TypeOffer.buy,
                    textTheme: textTheme,
                    size: size,
                    viewModel: viewModel,
                  ),
                  ListCreateOfferSwitch(
                    type: TypeOffer.sell,
                    textTheme: textTheme,
                    size: size,
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

class ListCreateOfferSwitch extends StatelessWidget {
  const ListCreateOfferSwitch({
    Key? key,
    required this.type,
    required this.textTheme,
    required this.size,
    required this.viewModel,
  }) : super(key: key);

  final TypeOffer type;
  final TextTheme textTheme;
  final Size size;
  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final DataUserProvider dataUserProvider = context.read<DataUserProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: false
          ? ListMyOffersSale(
              'data',
              textTheme: textTheme,
              viewModel: viewModel,
            )
          : NotOffersYet(
              viewModel: viewModel,
              textTheme: textTheme,
              size: size,
              type: type,
            ),
    );
  }
}

class NotOffersYet extends StatelessWidget {
  const NotOffersYet({
    Key? key,
    required this.viewModel,
    required this.textTheme,
    required this.size,
    required this.type,
  }) : super(key: key);

  final HomeViewModel viewModel;
  final TextTheme textTheme;
  final Size size;
  final TypeOffer type;

  @override
  Widget build(BuildContext context) {
    final DataUserProvider dataUserProvider = context.read<DataUserProvider>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: SvgPicture.asset(
            viewModel.status.image,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Expanded(
          flex: 2,
          child: Column(
            children: <Widget>[
              Text(
                viewModel.status.titleText,
                style: textTheme.textBigBlack,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                width: size.width * .7,
                child: Text(
                    'Crea tu primera oferta y vuelve aqui para hacerle seguimineto',
                    textAlign: TextAlign.center,
                    style: textTheme.textSmallBlack),
              ),
            ],
          ),
        ),
        PrimaryButtonCustom(
          viewModel.status.buttonText,
          onPressed: () {
            dataUserProvider.getDataUserLogged != null
                ? viewModel.goCreateOffer(context, type)
                : viewModel.goLogin(context);
          },
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }
}
