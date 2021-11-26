import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mi_daily/commons/dly_assets.dart';
import 'package:mi_daily/commons/dly_colors.dart';
import 'package:mi_daily/commons/dly_constans.dart';
import 'package:mi_daily/commons/dly_icons.dart';
import 'package:mi_daily/generated/l10n.dart';

import '../../../../app_theme.dart';

class HomeScreen extends StatefulWidget {

  final bool hideWallet;
  final VoidCallback changeHideWallet;
  final bool hideValues;
  final VoidCallback changeHideValues;
  final VoidCallback goDetail;
  final VoidCallback goReward;
  final VoidCallback goCrypto;

  const HomeScreen(this.changeHideWallet, this.changeHideValues,
      this.goDetail, this.goReward, this.goCrypto,
      {this.hideWallet = false, this.hideValues = false,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final GlobalKey<RefreshIndicatorState> keyRefresh = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    final I18n i18n = I18n.current;

    Widget _buttonHideValues() {

      return MaterialButton(
        color: DlyColors.yellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        visualDensity: VisualDensity.comfortable,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        onPressed: widget.changeHideValues,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              widget.hideValues ? DlyIcons.eye : DlyIcons.eyeClose,
              color: DlyColors.black,
              size: widget.hideValues ? 14 : 16,
            ),
            Padding(
              padding: EdgeInsets.only(left: widget.hideValues ? 12 : 10, top: 1),
              child: Text(
                widget.hideValues ? i18n.viewValues : i18n.hideValues,
                style: textTheme.subtitleBlack.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget walletComponent() {

      return IntrinsicHeight(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 3,
                child: Container(color: DlyColors.yellow),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            i18n.walletsValue,
                            style: textTheme.titleYellow.copyWith(
                              fontSize: 19,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          _buttonHideValues()
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Center(
                            child: Icon(
                              DlyIcons.dly,
                              color: DlyColors.white,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 40),
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerRight,
                                child: RichText(
                                  text: TextSpan(
                                    text: widget.hideValues ? DlyConstants.asterisks : '1.250.000.000',
                                    style: textTheme.bigNumberWhite,
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: widget.hideValues ? '' : ',00',
                                        style: textTheme.textGrayLight.copyWith(
                                          fontSize: 24,
                                        ),
                                      ),
                                    ],
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Text>[
                          Text(
                            '2 ${i18n.wallets}',
                            style: textTheme.textGray,
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            '≈ \$ ${widget.hideValues ? DlyConstants.asterisks : '172.400,72'} USD',
                            style: textTheme.textGray,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget dailysComponent() {

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              DlyColors.gray.withOpacity(1),
              DlyColors.gray,
            ],
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: DlyColors.blackDark.withOpacity(0.7),
              blurRadius: 7.0,
              spreadRadius: 1,
              offset: const Offset(0, 0.5),
            )
          ],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Transform.rotate(
          angle: 0.058,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            decoration: BoxDecoration(
              color: DlyColors.grayCardBg.withOpacity(0.8),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Transform.rotate(
              angle: -0.058,
              child: InkWell(
                onTap: widget.goDetail,
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        i18n.myDailys,
                        style: textTheme.textGray.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Center(
                            child: CircleAvatar(
                              backgroundColor: DlyColors.grayIconBg,
                              minRadius: 25,
                              child: Padding(
                                padding: EdgeInsets.only(left: 3),
                                child: Icon(
                                  DlyIcons.dIcon,
                                  color: DlyColors.yellow,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: widget.hideValues ? DlyConstants.asterisks : '9.950.000',
                              style: textTheme.mediumNumberYellow.copyWith(
                                fontSize: 28,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: widget.hideValues ? '' : ',00',
                                  style: textTheme.titleYellow,
                                ),
                              ],
                            ),
                            maxLines: 1,
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(bottom: 8, top: 10, left: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    i18n.TLR,
                                    style: textTheme.textGrayLight,
                                  ),
                                  const SizedBox(width: 10),
                                  Flexible(
                                    child: FittedBox(
                                      child: Text(
                                        widget.hideValues ? DlyConstants.asterisks : '1.950.000',
                                        style: textTheme.textGrayLight,
                                        maxLines: 1,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: SizedBox(
                                  width: 2,
                                  child: Container(
                                    color: DlyColors.grayTextLight,
                                  ),
                                ),
                              ),
                              // const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    i18n.BNF,
                                    style: textTheme.textGrayLight,
                                  ),
                                  const SizedBox(width: 10),
                                  Flexible(
                                    child: FittedBox(
                                      child: Text(
                                        widget.hideValues ? DlyConstants.asterisks : '950.000',
                                        style: textTheme.textGrayLight,
                                        maxLines: 1,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    Widget rewardComponent() {

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        padding: const EdgeInsets.only(left: 25),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              DlyColors.gray,
              DlyColors.gray.withOpacity(0.85),
            ],
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: DlyColors.blackDark.withOpacity(0.7),
              blurRadius: 12.0,
              spreadRadius: 1,
              offset: const Offset(0, 0.5),
            )
          ],
          borderRadius: BorderRadius.circular(30),
        ),
        child: InkWell(
          onTap: widget.goReward,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20),
              Text(
                'Recompensa',
                style: textTheme.textGray.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Icon(
                          DlyIcons.dly,
                          color: DlyColors.white,
                          size: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                text: widget.hideValues ? DlyConstants.asterisks : '6.950.000',
                                style: textTheme.mediumNumberWhite.copyWith(
                                  fontSize: 28,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: widget.hideValues ? '' : ',00',
                                    style: textTheme.subtitleWhite,
                                  ),
                                ],
                              ),
                              maxLines: 1,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '≈ \$ ${widget.hideValues ? DlyConstants.asterisks : '172.400,72'} USD',
                              style: textTheme.textGray,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    DlyIcons.keyboardArrowRight,
                    color: DlyColors.white,
                    size: 55,
                  )
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),

      );
    }

    Widget availableComponent() {

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        padding: const EdgeInsets.only(left: 25),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              DlyColors.gray,
              DlyColors.gray.withOpacity(0.85),
            ],
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: DlyColors.blackDark.withOpacity(0.7),
              blurRadius: 12.0,
              spreadRadius: 1,
              offset: const Offset(0, 0.5),
            )
          ],
          borderRadius: BorderRadius.circular(30),
        ),
        child: InkWell(
          onTap: widget.goCrypto,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20),
              Text(
                i18n.available,
                style: textTheme.textGray.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Icon(
                          DlyIcons.dly,
                          color: DlyColors.yellow,
                          size: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                text: widget.hideValues ? DlyConstants.asterisks : '6.950.000',
                                style: textTheme.mediumNumberYellow.copyWith(
                                  fontSize: 28,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: widget.hideValues ? '' : ',00',
                                    style: textTheme.titleYellow,
                                  ),
                                ],
                              ),
                              maxLines: 1,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '≈ \$ ${widget.hideValues ? DlyConstants.asterisks : '172.400,72'} USD',
                              style: textTheme.textGray,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    DlyIcons.keyboardArrowRight,
                    color: DlyColors.white,
                    size: 55,
                  )
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),

      );
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            DlyColors.grayBg,
            DlyColors.grayDark,
          ],
        ),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            height:  widget.hideWallet ? size.height * 0.25 : size.height * 0.4,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  DlyColors.blackBg,
                  DlyColors.black.withOpacity(0.85),
                ],
              ),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(25),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 35, top: 30),
                  child: SvgPicture.asset(
                    DlyAssets.logo,
                    height: 50,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 20, top: 30),
                  child: Icon(
                    DlyIcons.bell,
                    size: 25,
                    color: DlyColors.white,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 115),
            child: RefreshIndicator(
              key: keyRefresh,
              onRefresh: () async {
                keyRefresh.currentState?.show(atTop: false);
                await Future<Duration>.delayed(const Duration(seconds: 1));
              },
              child: ListView(
                children: <Widget>[
                  if (widget.hideWallet)
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: _buttonHideValues(),
                    ) else
                    Column(
                      children: <Widget>[
                        walletComponent(),
                        const SizedBox(height: 55),
                        dailysComponent(),
                        const SizedBox(height: 28),
                        rewardComponent(),
                      ],
                    ),
                  SizedBox(height: widget.hideWallet ? 15 : 18),
                  availableComponent(),
                  const SizedBox(height: 15),
                  IconButton(
                    icon: RotatedBox(
                      quarterTurns: widget.hideWallet ? -45 : 45,
                      child: const Icon(
                        DlyIcons.backArrow,
                        color: DlyColors.yellow,
                        size: 34,
                      ),
                    ),
                    onPressed: widget.changeHideWallet,
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
