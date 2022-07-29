import 'package:flutter/material.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/commons/ld_enums.dart';
import 'package:localdaily/pages/home/home_view_model.dart';
import 'package:localdaily/pages/home/ui/components/advice_message.dart';
import 'package:localdaily/pages/home/ui/components/snack_suggestion_connect_midaily.dart';
import 'package:localdaily/pages/home/ui/home_view.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/data.dart';
import 'package:localdaily/widgets/LoadingIconScroll.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ListOperationsOffers extends StatelessWidget {
  const ListOperationsOffers({
    Key? key,
    required this.textTheme,
    required this.userId,
    required this.operationScrollCtrl,
  }) : super(key: key);

  final TextTheme textTheme;
  final String userId;
  final ScrollController operationScrollCtrl;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final HomeViewModel viewModel = context.watch<HomeViewModel>();
    final List<Data> items = viewModel.status.typeOffer == TypeOffer.buy
        ? viewModel.status.operationSaleData.data
        : viewModel.status.operationBuyData.data;

    return RefreshIndicator(
      color: LdColors.orangePrimary,
      onRefresh: () async {
        await viewModel.getData(userId,
            refresh: true,
        );
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
            const SnackSuggestionConnectMiDaily(
              'Asegurate de teber tu sesion iniciada en la App MiDaily',
            ),
            const Divider(
              height: 8,
              color: LdColors.gray,
            ),
            Expanded(
              child: Stack(
                children: <Widget> [
                  ListView.separated(
                    controller: operationScrollCtrl,
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 8,
                      );
                    },
                    shrinkWrap: items.isEmpty,
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 30),
                                  child: IntrinsicHeight(
                                    child: AdviceMessage(
                                      imageName: LdAssets.emptyNotification,
                                      title: viewModel.status.typeOffer ==
                                              TypeOffer.buy
                                          ? viewModel.countFilters() > 0
                                              ? 'No hay publicaciones para estos filtros'
                                              : 'Aún no tienes compras en proceso'
                                          : viewModel.countFilters() > 0
                                              ? 'No hay publicaciones para estos filtros'
                                              : 'Aún no tienes ventas en proceso',
                                      description: viewModel.countFilters() > 0
                                          ? 'Por favor seleccione nuevos criterios'
                                          : 'Puedes ir al inicio y buscar alguna publicación que te llame la atención.',
                                    ),
                                  ),
                                )
                              : OperationCard(
                                  onTap: () {
                                    viewModel.goDetailOperOffer(
                                      context,
                                      items[index].advertisement.id,
                                      'Operacion',
                                    );
                                  },
                                  item: items[index],
                                  textTheme: textTheme,
                                  viewModel: viewModel,
                                );
                    },
                  ),
                  if (viewModel.status.isLoadingScroll)
                    Positioned(
                      bottom: 10,
                      left: size.width * 0.5 - 40,
                      child: const LoadingIconScroll(),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
