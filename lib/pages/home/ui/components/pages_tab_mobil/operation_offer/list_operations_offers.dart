import 'package:flutter/material.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/commons/ld_enums.dart';
import 'package:localdaily/pages/home/home_view_model.dart';
import 'package:localdaily/pages/home/ui/components/advice_message.dart';
import 'package:localdaily/pages/home/ui/home_view.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/data.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ListOperationsOffers extends StatelessWidget {
  const ListOperationsOffers({
    Key? key,
    required this.textTheme,
    required this.userId,
  }) : super(key: key);

  final TextTheme textTheme;
  final String userId;

  @override
  Widget build(BuildContext context) {
    final HomeViewModel viewModel = context.watch<HomeViewModel>();
    final List<Data> items = viewModel.status.typeOffer == TypeOffer.buy
        ? viewModel.status.operationSaleData.data
        : viewModel.status.operationBuyData.data;

    return RefreshIndicator(
      onRefresh: () async {
        await viewModel.getData(context, userId, refresh: true);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: Column(
          children: <Widget>[
            OptionsFilterRow(
              textTheme: textTheme,
              quantityFilter: 2,
            ),
            const Divider(
              height: 8,
              color: LdColors.gray,
            ),
            Expanded(
              child: Center(
                child: ListView.separated(
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
                  itemCount: viewModel.status.isLoading ? 3 : items.length + 1,
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
                                        ? 'Aún no tienes compras en proceso'
                                        : 'Aún no tienes ventas en proceso',
                                    description:
                                        'Puedes ir al inicio y buscar alguna publicación que te llame la atención.',
                                  ),
                                ),
                              )
                            : OperationCard(
                                onTap: () {},
                                item: items[index],
                                textTheme: textTheme,
                                viewModel: viewModel,
                              );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
