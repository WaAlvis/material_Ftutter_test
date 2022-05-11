import 'package:flutter/material.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/commons/ld_enums.dart';
import 'package:localdaily/pages/home/home_view_model.dart';
import 'package:localdaily/pages/home/ui/components/advice_message.dart';
import 'package:localdaily/pages/home/ui/home_view.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/data.dart';
import 'package:localdaily/utils/midaily_connect.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ListOffersMainSwitch extends StatelessWidget {
  const ListOffersMainSwitch(
    this.data, {
    Key? key,
    required this.textTheme,
    required this.userId,
    required this.mainScrollCtrl,
  }) : super(key: key);

  final String data;
  final TextTheme textTheme;
  final String userId;
  final ScrollController mainScrollCtrl;

  @override
  Widget build(BuildContext context) {
    final HomeViewModel viewModel = context.watch<HomeViewModel>();
    final DataUserProvider userProvider = context.watch<DataUserProvider>();
    final List<Data> items = viewModel.status.typeOffer == TypeOffer.buy
        ? viewModel.status.offersSaleDataHome.data
        : viewModel.status.offersBuyDataHome.data;

    return RefreshIndicator(
      color: LdColors.orangePrimary,
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
              quantityFilter: viewModel.countFilters(),
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
                controller: mainScrollCtrl,
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 8,
                  );
                },
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
                      : index == 0
                          ? Column(
                              children: <Widget>[
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 500),
                                  child: userId.isNotEmpty &&
                                          (userProvider.getAddress == null ||
                                              userProvider.getAddress == '')
                                      ? CardWalletConnect(
                                          onTap: () =>
                                              MiDailyConnect.createConnection(
                                            context,
                                            DailyConnectType.walletAddress,
                                            '',
                                            '',
                                          ),
                                          textTheme: textTheme,
                                          connected: false,
                                        )
                                      : const SizedBox.shrink(),
                                ),
                                if (items.isEmpty)
                                  IntrinsicHeight(
                                    child: AdviceMessage(
                                      imageName: LdAssets.emptyNotification,
                                      title: viewModel.status.typeOffer ==
                                              TypeOffer.sell
                                          ? viewModel.countFilters() > 0
                                              ? 'No hay publicaciones para estos filtros'
                                              : 'Aún no hay ofertas de ventas'
                                          : viewModel.countFilters() > 0
                                              ? 'No hay publicaciones para estos filtros'
                                              : 'Aún no hay ofertas de compras',
                                      description: viewModel.status.typeOffer ==
                                              TypeOffer.sell
                                          ? viewModel.countFilters() > 0
                                              ? 'Por favor seleccione nuevos criterios'
                                              : 'Aquí podrás visualizar las ofertas de ventas creadas por la comunidad.'
                                          : viewModel.countFilters() > 0
                                              ? 'Por favor seleccione nuevos criterios'
                                              : 'Aquí podrás visualizar las ofertas de compras creadas por la comunidad.',
                                    ),
                                  )
                              ],
                            )
                          : CardBuyAndSell(
                              onTap: () {
                                userId.isEmpty
                                    ? viewModel.goLogin(context)
                                    : viewModel.goDetailOffer(
                                        context,
                                        item: items[index - 1],
                                        isBuy: viewModel.status.typeOffer ==
                                            TypeOffer.sell,
                                      );
                              },
                              item: items[index - 1],
                              textTheme: textTheme,
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
