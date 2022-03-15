import 'package:flutter/material.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/pages/home/home_view_model.dart';
import 'package:localdaily/pages/home/ui/home_view.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/data.dart';
import 'package:shimmer/shimmer.dart';

class ListOperationsOffers extends StatelessWidget {
  const ListOperationsOffers(
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
              itemCount: viewModel.status.isLoading ? 3 : items.length,
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
                    : OperationCard(
                        onTap: () {},
                        item: items[index],
                        textTheme: textTheme,
                        viewModel: viewModel,
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
