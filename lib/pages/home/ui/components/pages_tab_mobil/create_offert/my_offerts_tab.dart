part of '../../../home_view.dart';

enum TypeOffert { buy, sell }

class MyOffertsTab extends StatelessWidget {
  const MyOffertsTab({
    required this.viewModel,
    required this.textTheme,
    required this.listBanks,
    required this.hAppbar,
    required this.hBody,
  });

  final HomeViewModel viewModel;
  final TextTheme textTheme;
  final List<Bank> listBanks;
  final double hAppbar;
  final double hBody;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    //Alturas de el APpbar y el body


    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: LdAppbar(
        title: 'Mis ofertas',
        goLogin: (context) => viewModel.goLogin(context),
        // withBackIcon: false,
      ),
      body: DefaultTabController(
        length: 2,
        child: Container(
          color: LdColors.white,
          child: Column(
            children: <Widget>[
              Container(
                // width: size.width,
                color: LdColors.blackBackground,
                child: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: <Widget>[
                    // Esto es el circulo, ideal volverlo widget
                    Positioned(
                      right: 0,
                      child: SizedBox(
                        // El tamaño depende del tamaño de la pantalla
                        width: (size.width) / 4,
                        height: (size.width) / 4,
                        child: QuarterCircle(
                          circleAlignment: CircleAlignment.bottomRight,
                          color: LdColors.grayLight.withOpacity(0.05),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: SizedBox(
                        width: (size.width) * 2 / 4,
                        height: (size.width) * 2 / 4,
                        child: QuarterCircle(
                          circleAlignment: CircleAlignment.bottomRight,
                          color: LdColors.grayLight.withOpacity(0.05),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: SizedBox(
                        width: (size.width) * 3 / 4,
                        height: (size.width) * 3 / 4,
                        child: QuarterCircle(
                          circleAlignment: CircleAlignment.bottomRight,
                          color: LdColors.grayLight.withOpacity(0.05),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: hAppbar),
                    ),
                    Column(
                      children: [
                        TabBar(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          indicatorColor: LdColors.orangePrimary,
                          indicatorWeight: 3,
                          labelColor: Colors.grey,
                          onTap: (int tab) {
                            if (tab == 0) {
                              viewModel.swapType(TypeOffert.buy);
                            }
                            if (tab == 1) {
                              viewModel.swapType(TypeOffert.sell);
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
                    )
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    CreateOffertSwitch(
                        type: TypeOffert.buy,
                        textTheme: textTheme,
                        size: size,
                        viewModel: viewModel),
                    CreateOffertSwitch(
                        type: TypeOffert.sell,
                        textTheme: textTheme,
                        size: size,
                        viewModel: viewModel),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CreateOffertSwitch extends StatelessWidget {
  CreateOffertSwitch({
    Key? key,
    required this.type,
    required this.textTheme,
    required this.size,
    required this.viewModel,
  }) : super(key: key);

  final TypeOffert type;
  final TextTheme textTheme;
  final Size size;
  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),

      child: Column(
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
            onPressed: () => viewModel.goCreateOffert(context, type),
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
