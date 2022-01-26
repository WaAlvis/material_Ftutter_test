import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/providers/user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/create_offerts/get_banks/response/bank.dart';
import 'package:localdaily/widgets/formatters_input_custom.dart';
import 'package:localdaily/widgets/input_text_custom.dart';
import 'package:localdaily/widgets/ld_appbar.dart';
import 'package:localdaily/widgets/ld_footer.dart';
import 'package:localdaily/widgets/primary_button.dart';
import 'package:localdaily/widgets/progress_indicator_local_d.dart';
import 'package:localdaily/widgets/quarter_circle.dart';
import 'package:provider/provider.dart';

import '../detail_offer_buy_view_model.dart';



part 'components/orange_table_sale.dart';

part 'detail_offert_buy_mobile.dart';

part 'detail_offert_buy_web.dart';

class DetailOfferBuyView extends StatelessWidget {
  const DetailOfferBuyView({Key? key, this.isBuy = false}) : super(key: key);

  final bool isBuy;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ChangeNotifierProvider<DetailOfferBuyViewModel>(
      create: (_) => DetailOfferBuyViewModel(
        locator<LdRouter>(),
        locator<ServiceInteractor>(),
      ),
      builder: (BuildContext context, _) {
        return _DetailOfferBuyBody(isBuy: isBuy);
      },
    );
  }
}

class _DetailOfferBuyBody extends StatefulWidget {
  const _DetailOfferBuyBody({Key? key, required this.isBuy}) : super(key: key);

  final bool isBuy;

  @override
  _DetailOfferBuyBodyState createState() => _DetailOfferBuyBodyState();
}

class _DetailOfferBuyBodyState extends State<_DetailOfferBuyBody> {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  final TextEditingController marginCtrl = TextEditingController();
  final TextEditingController amountDLYCtrl = TextEditingController();
  final TextEditingController accountNumCtrl = TextEditingController();
  final TextEditingController docNumCtrl = TextEditingController();
  final TextEditingController nameTitularAccountCtrl = TextEditingController();
  final TextEditingController infoPlusOffertCtrl = TextEditingController();

  final TextEditingController cancelSecretCtrl = TextEditingController();

  //final TextEditingController usuarioCtrl = TextEditingController();

  @override
  void dispose() {
    marginCtrl.dispose();
    amountDLYCtrl.dispose();
    accountNumCtrl.dispose();
    docNumCtrl.dispose();
    nameTitularAccountCtrl.dispose();
    infoPlusOffertCtrl.dispose();

    cancelSecretCtrl.dispose();
    //usuarioCtrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<DetailOfferBuyViewModel>().onInit(context);
    });
    amountDLYCtrl.addListener(_printLatestValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DetailOfferBuyViewModel viewModel = context.watch<DetailOfferBuyViewModel>();
    final Widget loading = viewModel.status.isLoading
        ? ProgressIndicatorLocalD()
        : SizedBox.shrink();

    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        final double maxWidth = constraints.maxWidth;
        return Stack(
          children: [
            CustomScrollView(
              slivers: <Widget>[
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: maxWidth > 1024
                      ? _DetailOffertBuyWeb(
                          keyForm: keyForm,
                          valueDLYCOP: amountDLYCtrl,
                          isBuy: widget.isBuy,
                        )
                      : _DetailOfferBuyMobile(
                          keyForm: keyForm,
                          docNumCtrl: docNumCtrl,
                          marginCtrl: marginCtrl,
                          accountNumCtrl: accountNumCtrl,
                          nameTitularAccountCtrl: nameTitularAccountCtrl,
                          amountDLYCtrl: amountDLYCtrl,
                          infoPlusOffertCtrl: infoPlusOffertCtrl,
                          cancelSecretCtrl: cancelSecretCtrl,
                        ),
                ),
              ],
            ),
            loading,
          ],
        );
      },
    );
  }

  void _printLatestValue() {
    print('Second text field: ${amountDLYCtrl.text}');
  }
}
