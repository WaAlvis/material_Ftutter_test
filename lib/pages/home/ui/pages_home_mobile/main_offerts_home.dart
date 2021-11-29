import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/pages/home/home_view_model.dart';
import 'package:localdaily/pages/home/ui/home_view.dart';
import 'package:localdaily/services/models/home/reponse/data.dart';

class MainOffertsHome extends StatelessWidget {
  const MainOffertsHome({
    required this.viewModel,
    required this.textTheme,
    required this.itemsBuyers,
    required this.itemsSellers,
  });

  final HomeViewModel viewModel;
  final TextTheme textTheme;
  final List<Data> itemsBuyers;
  final List<Data> itemsSellers;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: LdColors.black,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                color: LdColors.blackBackground,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SvgPicture.asset(
                        LdAssets.logo,
                        width: 150,
                      ),
                      IconButton(
                        onPressed: () => viewModel.goLogin(context),
                        icon: const Icon(
                          Icons.account_circle,
                          color: LdColors.white,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  // backgroundColor: Colors.blueAccent,
                  appBar: PreferredSize(
                    preferredSize:
                        const Size.fromHeight(kMinInteractiveDimension + 1),
                    child: Container(
                      color: LdColors.blackBackground,
                      child: Column(
                        children: <Widget>[
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
                        ],
                      ),
                    ),
                  ),
                  body: TabBarView(
                    children: <Widget>[
                      RefreshIndicator(
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Ofertas para comprar',
                                  textAlign: TextAlign.center,
                                  style: textTheme.textBlack.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: LdColors.orangePrimary),
                                ),
                              ),
                              Expanded(
                                child: ListView.separated(
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const SizedBox(
                                      height: 8,
                                    );
                                  },
                                  // controller: _scrollController,
                                  itemCount: itemsBuyers.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return CardBuyAndSell(
                                      index: index,
                                      items: itemsBuyers,
                                      textTheme: textTheme,
                                      viewModel: viewModel, //Pase bien el VM
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      RefreshIndicator(
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
                                  textTheme: textTheme, quantityFilter: 3),
                              const Divider(
                                height: 8,
                                color: LdColors.gray,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Ofertas para vender',
                                  textAlign: TextAlign.center,
                                  style: textTheme.textBlack.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: LdColors.orangePrimary),
                                ),
                              ),
                              Expanded(
                                child: ListView.separated(
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const SizedBox(
                                      height: 8,
                                    );
                                  },
                                  // controller: _scrollController,
                                  itemCount: itemsSellers.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return CardBuyAndSell(
                                      index: index,
                                      items: itemsSellers,
                                      textTheme: textTheme,
                                      viewModel: viewModel,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
