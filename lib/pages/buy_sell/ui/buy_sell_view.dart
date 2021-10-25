import 'package:flutter/material.dart';
import 'package:localdaily/api/repository/interactor/api_interactor.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/buy_sell/buy_sell_view_model.dart';
import 'package:localdaily/widgets/ld_app_bar.dart';
import 'package:localdaily/widgets/ld_footer.dart';
import 'package:provider/provider.dart';

part 'buy_sell_mobile.dart';
part 'buy_sell_web.dart';
part 'components/filter_buy_sell.dart';
part 'components/table_buy_sell.dart';

class BuySellView extends StatelessWidget {
  const BuySellView({Key? key, this.isBuy = false}) : super(key: key);

  final bool isBuy;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BuySellViewModel>(
      create: (_) => BuySellViewModel(
          locator<LdRouter>(),
          locator<ApiInteractor>(),
      ),
      builder: (BuildContext context, _) {
        return Scaffold(
          backgroundColor: LdColors.white,
          body: _BuySellBody(isBuy: isBuy),
        );
      },
    );
  }
}

class _BuySellBody extends StatefulWidget {

  const _BuySellBody({Key? key, required this.isBuy}) : super(key: key);

  final bool isBuy;

  @override
  _BuySellBodyState createState() => _BuySellBodyState();
}

class _BuySellBodyState extends State<_BuySellBody> {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  final TextEditingController passwordCtrl = TextEditingController();

  @override
  void dispose() {
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final BuySellViewModel viewModel = context.watch<BuySellViewModel>();

    return LayoutBuilder(builder: (_, BoxConstraints constraints) {
      final double maxWidth = constraints.maxWidth;

      return CustomScrollView(
        slivers: <Widget>[
          SliverFillRemaining(
            hasScrollBody: false,
            child: maxWidth > 1024
              ? _BuySellWeb(
                  keyForm: keyForm,
                  passwordCtrl: passwordCtrl,
                  isBuy: widget.isBuy,
                )
              : _BuySellMobile(
                  keyForm: keyForm,
                  passwordCtrl: passwordCtrl,
                ),
          )
        ],
      );
    },);
  }
}
