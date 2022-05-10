import 'package:flutter/material.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/commons/ld_enums.dart';
import 'package:localdaily/pages/home/home_view_model.dart';
import 'package:localdaily/pages/home/ui/components/advice_message.dart';
import 'package:localdaily/pages/home/ui/home_view.dart';
import 'package:localdaily/pages/offer_sale/ui/offer_sale_view.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/data.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ListMyOffersSale extends StatelessWidget {
  const ListMyOffersSale({
    Key? key,
    required this.textTheme,
    required this.userId,
    required this.offerScrollCtrl,
  }) : super(key: key);

  final TextTheme textTheme;
  final String userId;
  final ScrollController offerScrollCtrl;

  @override
  Widget build(BuildContext context) {
    final HomeViewModel viewModel = context.watch<HomeViewModel>();
    final List<Data> items = viewModel.status.typeOffer == TypeOffer.buy
        ? viewModel.status.myOfferBuyData.data
        : viewModel.status.myOfferSaleData.data;

    return RefreshIndicator(
      color: LdColors.orangePrimary,
      onRefresh: () async {
        viewModel.getData(context, userId, refresh: true);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: Column(
          children: <Widget>[
            OptionsFilterRow(
              textTheme: textTheme,
              quantityFilter: viewModel.countFilters(),
            ),
            const Divider(
              height: 8,
              color: LdColors.gray,
            ),
            Expanded(
              child: ListView.separated(
                controller: offerScrollCtrl,
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 8,
                  );
                },
                padding: EdgeInsets.zero,
                itemCount: viewModel.status.isLoading
                    ? 3
                    : items.isEmpty
                        ? items.length + 1
                        : items.length,
                itemBuilder: (BuildContext context, int index) {
                  return viewModel.status.isLoading
                      ? Shimmer.fromColors(
                          baseColor: LdColors.whiteDark,
                          highlightColor: LdColors.grayButton,
                          child: const Card(
                            margin: EdgeInsets.all(10),
                            child: SizedBox(height: 160),
                          ),
                        )
                      : items.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30),
                              child: IntrinsicHeight(
                                child: AdviceMessage(
                                  imageName: viewModel.status.typeOffer ==
                                          TypeOffer.buy
                                      ? LdAssets.buyNoOffer
                                      : LdAssets.saleNoOffer,
                                  title: viewModel.status.typeOffer ==
                                          TypeOffer.buy
                                      ? viewModel.status.extraFilters != null
                                          ? 'No hay publicaciones para estos filtros'
                                          : 'Aun no tienes ofertas de compra'
                                      : viewModel.status.extraFilters != null
                                          ? 'No hay publicaciones para estos filtros'
                                          : 'Aun no tienes ofertas de ventas',
                                  description: viewModel.status.extraFilters !=
                                          null
                                      ? 'Por favor seleccione nuevos criterios'
                                      : 'Crea tu primera oferta y vuelve aqui para hacerle seguimiento.',
                                  btnText: viewModel.status.typeOffer ==
                                          TypeOffer.buy
                                      ? 'Crear oferta de compra'
                                      : 'Crear oferta de venta',
                                  onPressed: () => userId.isNotEmpty
                                      ? viewModel.goCreateOffer(context)
                                      : viewModel.goLogin(context),
                                ),
                              ),
                            )
                          : MyOfferCard(
                              item: items[index],
                              textTheme: textTheme,
                              viewModel: viewModel, //Pase bien el VM
                            );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
