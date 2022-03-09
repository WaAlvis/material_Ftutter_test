import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/home/home_view_model.dart';
import 'package:localdaily/pages/home/ui/home_view.dart';
import 'package:localdaily/pages/offer_sale/offer_sale_view_model.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/bank.dart';
import 'package:localdaily/services/models/create_offers/get_doc_type/response/doc_type.dart';
import 'package:localdaily/widgets/appbar_circles.dart';
import 'package:localdaily/widgets/formatters_input_custom.dart';
import 'package:localdaily/widgets/input_text_custom.dart';
import 'package:localdaily/widgets/ld_appbar.dart';
import 'package:localdaily/widgets/ld_footer.dart';
import 'package:localdaily/widgets/primary_button.dart';
import 'package:localdaily/widgets/progress_indicator_local_d.dart';
import 'package:localdaily/widgets/quarter_circle.dart';
import 'package:provider/provider.dart';

part '../../home/ui/components/pages_tab_mobil/create_offer/my_offer_card.dart';

part 'components/card_login.dart';

part 'components/orange_table_sale.dart';

part 'offer_sale_mobile.dart';

part 'offer_sale_web.dart';

class OfferSaleView extends StatelessWidget {
  const OfferSaleView({Key? key, this.isBuy = false}) : super(key: key);

  final bool isBuy;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ChangeNotifierProvider<OfferSaleViewModel>(
      create: (_) => OfferSaleViewModel(
        locator<LdRouter>(),
        locator<ServiceInteractor>(),
      ),
      builder: (BuildContext context, _) {
        return _OfferSaleBody(isBuy: isBuy);
      },
    );
  }
}

class _OfferSaleBody extends StatefulWidget {
  const _OfferSaleBody({Key? key, required this.isBuy}) : super(key: key);

  final bool isBuy;

  @override
  _OfferSaleBodyState createState() => _OfferSaleBodyState();
}

class _OfferSaleBodyState extends State<_OfferSaleBody> {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  final TextEditingController marginCtrl = TextEditingController();
  final TextEditingController amountDLYCtrl = TextEditingController();
  final TextEditingController accountNumCtrl = TextEditingController();
  final TextEditingController docNumCtrl = TextEditingController();
  final TextEditingController nameTitularAccountCtrl = TextEditingController();
  final TextEditingController infoPlusOfferCtrl = TextEditingController();

  final TextEditingController cancelSecretCtrl = TextEditingController();

  //final TextEditingController usuarioCtrl = TextEditingController();

  @override
  void dispose() {
    marginCtrl.dispose();
    amountDLYCtrl.dispose();
    accountNumCtrl.dispose();
    docNumCtrl.dispose();
    nameTitularAccountCtrl.dispose();
    infoPlusOfferCtrl.dispose();

    cancelSecretCtrl.dispose();
    //usuarioCtrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<OfferSaleViewModel>().onInit(context);
    });
    amountDLYCtrl.addListener(_printLatestValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final OfferSaleViewModel viewModel = context.watch<OfferSaleViewModel>();
    final Widget loading = viewModel.status.isLoading
        ? ProgressIndicatorLocalD()
        : SizedBox.shrink();

    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        final double maxWidth = constraints.maxWidth;
        return Stack(
          children: [
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: maxWidth > 1024
                      ? _OfferSaleWeb(
                          keyForm: keyForm,
                          valueDLYCOP: amountDLYCtrl,
                          isBuy: widget.isBuy,
                        )
                      : _OfferSaleMobile(
                          keyForm: keyForm,
                          docNumCtrl: docNumCtrl,
                          marginCtrl: marginCtrl,
                          accountNumCtrl: accountNumCtrl,
                          nameTitularAccountCtrl: nameTitularAccountCtrl,
                          amountDLYCtrl: amountDLYCtrl,
                          infoPlusOfferCtrl: infoPlusOfferCtrl,
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
