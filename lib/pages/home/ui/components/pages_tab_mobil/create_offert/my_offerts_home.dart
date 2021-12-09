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
    return Container(
      color: LdColors.white,
      child: Column(
        children: <Widget>[

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
