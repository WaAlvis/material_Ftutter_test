import 'package:flutter/material.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/commons/ld_enums.dart';
import 'package:localdaily/pages/home/home_view_model.dart';
import 'package:localdaily/pages/home/ui/home_view.dart';
import 'package:localdaily/pages/offer_sale/ui/offer_sale_view.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/data.dart';
import 'package:provider/provider.dart';

class ListMyOffersSale extends StatelessWidget {
  const ListMyOffersSale({
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
        // keyRefresh.currentState?.show(atTop: false);
        await Future<Duration>.delayed(
          const Duration(seconds: 1),
        );
      },
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
            child: ListView.separated(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 8,
                );
              },
              padding: EdgeInsets.zero,
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return MyOfferCard(
                  item: items[index],
                  textTheme: textTheme,
                  viewModel: viewModel, //Pase bien el VM
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
