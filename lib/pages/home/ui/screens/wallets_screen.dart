import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mi_daily/commons/dly_colors.dart';
import 'package:mi_daily/commons/dly_icons.dart';
import 'package:mi_daily/generated/l10n.dart';

import '../../../../app_theme.dart';

class WalletsScreen extends StatefulWidget {

  @override
  _WalletsScreenState createState() => _WalletsScreenState();
}

class _WalletsScreenState extends State<WalletsScreen> {

  final GlobalKey<RefreshIndicatorState> keyRefresh = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    final I18n i18n = I18n.current;

    Widget totalWallet () {

      return Stack(
        children: <Widget>[
          Container(
            height: size.height * 0.15,
            decoration: const BoxDecoration(
              color: DlyColors.black,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30)
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            decoration: BoxDecoration(
              color: DlyColors.grayCard,
              borderRadius: BorderRadius.circular(30),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: DlyColors.blackDark.withOpacity(0.5),
                  blurRadius: 7.0,
                  spreadRadius: 1,
                  offset: const Offset(0, 0.5)
                )
              ]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 8),
                Text(
                  i18n.walletsTotal,
                  style: textTheme.titleYellow,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 15),
                Row(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Icon(
                        DlyIcons.dly,
                        color: DlyColors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 40),
                    Flexible(
                      child: FittedBox(
                        child: RichText(
                          text: TextSpan(
                            text: '125.000.000',
                            style: textTheme.bigNumberWhite.copyWith(
                              fontSize: 30
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: ',00',
                                style: textTheme.textGrayLight.copyWith(
                                  fontSize: 24
                                )
                              ),
                            ],
                          ),
                          maxLines: 1
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  i18n.lastDailys('12.09.20'),
                  style: textTheme.textGray,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 3),
              ],
            ),
          )
        ],
      );
    }

    Widget cardAvailable({bool available = false}) {

      return Container(
        margin: const EdgeInsets.only(bottom: 25, top: 5, left: 20, right: 20),
        padding: const EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          color: DlyColors.grayIconBg,
          borderRadius: BorderRadius.circular(30),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: DlyColors.blackDark.withOpacity(0.5),
              blurRadius: 6.0,
              spreadRadius: 0.5,
              offset: const Offset(0, 0.5)
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              width: size.width * 0.85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        i18n.wallet,
                        style: textTheme.subtitleWhite,
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        '#A001',
                        style: textTheme.labelInputWhite.copyWith(
                          fontWeight: FontWeight.normal
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: MaterialButton(
                      color: available ? DlyColors.yellow : DlyColors.grayLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      onPressed: (){},
                      child: Text(
                        available ? i18n.available : i18n.walletsPending,
                        style: textTheme.subtitleBlack.copyWith(
                          fontSize: 11
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: DlyColors.gray,
                borderRadius: BorderRadius.circular(30),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: DlyColors.blackDark.withOpacity(0.7),
                    blurRadius: 3.0,
                    offset: const Offset(0, 0.75)
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Icon(
                        DlyIcons.dly,
                        color: DlyColors.white,
                        size: 24,
                      ),
                      const SizedBox(width: 40),
                      Flexible(
                        child: FittedBox(
                          child: RichText(
                            text: TextSpan(
                              text: '50.000.000',
                              style: textTheme.mediumNumberWhite.copyWith(
                                fontSize: 30
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ',00',
                                  style: textTheme.textGrayLight.copyWith(
                                      fontSize: 20
                                  )
                                ),
                              ],
                            ),
                            maxLines: 1
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: size.width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: Container(
                            decoration: BoxDecoration(
                              color: DlyColors.black.withOpacity(0.75),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  i18n.rate,
                                  style: textTheme.textGray,
                                  textAlign: TextAlign.start,
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  '0,5%',
                                  style: textTheme.labelInputWhite.copyWith(
                                      fontWeight: FontWeight.normal
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Expanded(child: SizedBox(width: 5)),
                        Expanded(
                          flex: 9,
                          child: Container(
                            decoration: BoxDecoration(
                              color: DlyColors.black.withOpacity(0.75),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  i18n.walletCreated,
                                  style: textTheme.textGray,
                                  textAlign: TextAlign.start,
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  '03/02/2021',
                                  style: textTheme.labelInputWhite.copyWith(
                                      fontWeight: FontWeight.normal
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: DlyColors.grayBg,
      appBar: AppBar(
        title: Text(i18n.wallets),
        centerTitle: true,
        elevation: 0,
        backgroundColor: DlyColors.black,
        leading: const SizedBox.shrink(),
        actions: <Widget>[
          IconButton(
            icon: const Icon(DlyIcons.bell),
            tooltip: i18n.notifications,
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          totalWallet(),
          const SizedBox(height: 20),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                keyRefresh.currentState?.show(atTop: false);
                await Future<Duration>.delayed(const Duration(seconds: 1));
              },
              child: ListView.builder(
                // controller: _scrollController,
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return cardAvailable(available: index % 2 == 0);
                },
              ),
            ),
          )
        ],
      )
    );
  }
}