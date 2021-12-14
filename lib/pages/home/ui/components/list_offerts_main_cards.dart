import 'package:flutter/material.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/pages/home/home_view_model.dart';
import 'package:localdaily/pages/home/ui/home_view.dart';
import 'package:localdaily/services/models/home/get_offerts/reponse/data.dart';

class ListOffertsMainCards extends StatelessWidget {
  const ListOffertsMainCards(
    this.data, {
    Key? key,
    required this.textTheme,
    required this.items,
    required this.viewModel,
  }) : super(key: key);

  final String data;
  final TextTheme textTheme;
  final List<Data> items;
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                data,
                textAlign: TextAlign.center,
                style: textTheme.textBlack.copyWith(
                    fontWeight: FontWeight.w500, color: LdColors.orangePrimary),
              ),
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 8,
                  );
                },
                padding: EdgeInsets.zero,
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return CardBuyAndSell(
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
