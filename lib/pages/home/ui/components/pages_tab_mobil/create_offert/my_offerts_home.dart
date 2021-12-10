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

    return Container(
      color: LdColors.white,
      child: Column(
        children: <Widget>[
          Container(
            width: size.width,
            color: LdColors.blackBackground,
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: <Widget>[
                // Esto es el circulo, ideal volverlo widget
                Positioned(
                  right: 0,
                  child: SizedBox(
                    // El tamaño depende del tamaño de la pantalla
                    width: (size.width)/4,
                    height: (size.width)/4,
                    child: QuarterCircle(
                      circleAlignment: CircleAlignment.bottomRight,
                      color: LdColors.grayLight.withOpacity(0.05),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: SizedBox(
                    width: (size.width)*2/4,
                    height: (size.width)*2/4,
                    child: QuarterCircle(
                      circleAlignment: CircleAlignment.bottomRight,
                      color: LdColors.grayLight.withOpacity(0.05),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: SizedBox(
                    width: (size.width)*3/4,
                    height: (size.width)*3/4,
                    child: QuarterCircle(
                      circleAlignment: CircleAlignment.bottomRight,
                      color: LdColors.grayLight.withOpacity(0.05),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: size.height * 0.18),
                  child: Row(
                    children: [
                      Text('data')
                    ],
                  ),
                ),DefaultTabController(
                  length: 2,
                  child:
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
                          style: textTheme.textYellow.copyWith(
                              fontWeight: FontWeight.w400,
                              color: LdColors.orangePrimary),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Vender',
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
            flex: 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SvgPicture.asset(LdAssets.noOffertForSale),
                const SizedBox(
                  height: 12,
                ),
                const Text('Aun no tienes ofertas de venta'),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  'Crea tu primera oferta y vuelve aqui para hacerle seguimineto',
                  textAlign: TextAlign.center,
                ),
                PrimaryButtonCustom(
                  'Crear oferta de venta',
                  onPressed: () => viewModel.goCreateOffertSale(context),
                ),

                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
