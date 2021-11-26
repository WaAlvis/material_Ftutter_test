import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../app_theme.dart';

class WalletsScreen extends StatefulWidget {

  @override
  _WalletsScreenState createState() => _WalletsScreenState();
}

class _WalletsScreenState extends State<WalletsScreen> {

  final GlobalKey<RefreshIndicatorState> keyRefresh = GlobalKey<
      RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme
        .of(context)
        .textTheme;
    final Size size = MediaQuery
        .of(context)
        .size;


    return Scaffold(
        appBar: AppBar(
          title: Text('wallets scrren'),
          centerTitle: true,
          elevation: 0,
          leading: const SizedBox.shrink(),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.ten_k_outlined),
              onPressed: () {},
            ),
          ],
        ),
        body: Center(
          child: Text(
            'Wallet screen'
          ),
        ),
    );
  }
}