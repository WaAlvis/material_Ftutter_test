part of '../../../home_view.dart';

class MyOffertsTab extends StatelessWidget {
  const MyOffertsTab({
    required this.viewModel,
    required this.textTheme,
    required this.listBanks,
  });

  final HomeViewModel viewModel;
  final TextTheme textTheme;
  final List<Bank> listBanks;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    //Alturas de el APpbar y el body
    final double hAppbar = size.height *  0.18;
    final double hBody = size.height - hAppbar;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const LdAppbar(
        title: 'Mis ofertas',
        withBackIcon: false,
        withButton: true,
      ),
      body: Container(
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
                  DefaultTabController(
                    length: 2,
                    child: TabBar(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      indicatorColor: LdColors.orangePrimary,
                      indicatorWeight: 3,
                      labelColor: Colors.grey,
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
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: SvgPicture.asset(
                      LdAssets.noOffertForSale,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Aun no tienes ofertas de venta',
                          style: textTheme.textBigBlack,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 65.0),
                          child: Text(
                              'Crea tu primera oferta y vuelve aqui para hacerle seguimineto',
                              textAlign: TextAlign.center,
                              style: textTheme.textSmallBlack),
                        ),
                      ],
                    ),
                  ),
                  PrimaryButtonCustom(
                    'Crear oferta de venta',
                    onPressed: () => viewModel.goCreateOffertSale(context),
                  ),
                  const SizedBox(
                    height: 24,
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
