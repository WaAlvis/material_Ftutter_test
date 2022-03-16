import 'package:flutter/material.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/pages/home/home_view_model.dart';
import 'package:localdaily/pages/home/ui/home_view.dart';
import 'package:localdaily/pages/offer_sale/ui/offer_sale_view.dart';

class ListMyOffersSale extends StatelessWidget {
  const ListMyOffersSale(
    this.data, {
    Key? key,
    required this.textTheme,
    // required this.items,
    required this.viewModel,
  }) : super(key: key);

  final String data;
  final TextTheme textTheme;

  // final List<Data> items;
  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
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
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 8,
                );
              },
              padding: EdgeInsets.zero,
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return MyOfferCard(
                  // item: items[index],
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
