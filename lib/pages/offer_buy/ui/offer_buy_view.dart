import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/offer_buy/offer_buy_view_model.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/bank.dart';
import 'package:localdaily/widgets/formatters_input_custom.dart';
import 'package:localdaily/widgets/input_text_custom.dart';
import 'package:localdaily/widgets/ld_appbar.dart';
import 'package:localdaily/widgets/ld_footer.dart';
import 'package:localdaily/widgets/primary_button.dart';
import 'package:localdaily/widgets/progress_indicator_local_d.dart';
import 'package:localdaily/widgets/quarter_circle.dart';
import 'package:provider/provider.dart';

part 'components/orange_table_buy.dart';

part 'offer_buy_mobile.dart';

part 'offer_buy_web.dart';

class OfferBuyView extends StatelessWidget {
  const OfferBuyView({Key? key, this.isBuy = false}) : super(key: key);

  final bool isBuy;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ChangeNotifierProvider<OfferBuyViewModel>(
      create: (_) => OfferBuyViewModel(
        locator<LdRouter>(),
        locator<ServiceInteractor>(),
      ),
      builder: (BuildContext context, _) {
        return _OfferBuyBody(isBuy: isBuy);
      },
    );
  }
}

class _OfferBuyBody extends StatefulWidget {
  const _OfferBuyBody({Key? key, required this.isBuy}) : super(key: key);

  final bool isBuy;

  @override
  _OfferBuyBodyState createState() => _OfferBuyBodyState();
}

class _OfferBuyBodyState extends State<_OfferBuyBody> {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  final TextEditingController marginCtrl = TextEditingController();
  final TextEditingController amountDLYCtrl = TextEditingController();
  final TextEditingController infoPlusOfferCtrl = TextEditingController();
  final TextEditingController cancelSecretCtrl = TextEditingController();

  late FocusNode focusDLYCOP;

  //final TextEditingController usuarioCtrl = TextEditingController();

  @override
  void dispose() {
    marginCtrl.dispose();
    amountDLYCtrl.dispose();
    infoPlusOfferCtrl.dispose();
    focusDLYCOP.dispose();
    cancelSecretCtrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    focusDLYCOP = FocusNode();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<OfferBuyViewModel>().onInit(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final OfferBuyViewModel viewModel = context.watch<OfferBuyViewModel>();
    final Widget loading = viewModel.status.isLoading
        ? ProgressIndicatorLocalD()
        : const SizedBox.shrink();

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
                      ? _OfferBuyWeb(
                          keyForm: keyForm,
                          valueDLYCOP: marginCtrl,
                          isBuy: widget.isBuy,
                        )
                      : _OfferBuyMobile(
                          keyForm: keyForm,
                          focusDLYCOP: focusDLYCOP,
                          marginCtrl: marginCtrl,
                          infoPlusOfferCtrl: infoPlusOfferCtrl,
                          amountDLYCtrl: amountDLYCtrl,
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
}
