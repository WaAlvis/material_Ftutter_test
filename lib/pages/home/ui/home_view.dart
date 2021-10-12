import 'dart:async';

import 'package:flutter/material.dart';
import 'package:localdaily/api/repository/interactor/api_interactor.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/home/home_view_model.dart';
import 'package:provider/provider.dart';

import '../../../app_theme.dart';

part 'home_mobile.dart';
part 'home_web.dart';
part 'components/table_home.dart';
part 'components/product_home.dart';
part 'components/start_home.dart';
part 'components/security_home.dart';
part 'components/information_home.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (_) => HomeViewModel(
          locator<LdRouter>(),
          locator<ApiInteractor>(),
      ),
      builder: (BuildContext context, _) {
        return const Scaffold(
          backgroundColor: LdColors.white,
          body: _HomeBody(),
        );
      },
    );
  }
}

class _HomeBody extends StatefulWidget {
  const _HomeBody({Key? key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<_HomeBody> {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  final TextEditingController passwordCtrl = TextEditingController();

  @override
  void dispose() {
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final HomeViewModel viewModel = context.watch<HomeViewModel>();

    return LayoutBuilder(builder: (_, BoxConstraints constraints) {
      final double maxWidth = constraints.maxWidth;

      return CustomScrollView(
        slivers: <Widget>[
          SliverFillRemaining(
            hasScrollBody: false,
            child: maxWidth > 1024
              ? _HomeWeb(
                  keyForm: keyForm,
                  passwordCtrl: passwordCtrl,
                )
              : _HomeMobile(
                  keyForm: keyForm,
                  passwordCtrl: passwordCtrl,
                ),
          )
        ],
      );
    },);
  }
}
