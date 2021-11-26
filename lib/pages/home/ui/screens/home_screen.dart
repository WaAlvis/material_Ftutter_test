import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../app_theme.dart';

class HomeScreen extends StatefulWidget {
  final bool hideWallet;
  final VoidCallback changeHideWallet;
  final bool hideValues;
  final VoidCallback changeHideValues;
  // final VoidCallback goDetail;
  // final VoidCallback goReward;
  // final VoidCallback goCrypto;

  const HomeScreen(
    this.changeHideWallet,
    this.changeHideValues,
    // this.goDetail,
    // this.goReward,
    // this.goCrypto,
  {
    this.hideWallet = false,
    this.hideValues = false,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<RefreshIndicatorState> keyRefresh =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    return Center(
      child: Text('Hola'),
    );
  }
}
