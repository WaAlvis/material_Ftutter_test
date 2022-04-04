import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/commons/ld_enums.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/detail_offer_buy/detail_offer_buy_effect.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/bank.dart';
import 'package:localdaily/services/models/create_offers/get_doc_type/response/doc_type.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/advertisement.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/data.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/user_data_home.dart';
import 'package:localdaily/widgets/appbar_circles.dart';
import 'package:localdaily/widgets/dropdown_custom.dart';
import 'package:localdaily/widgets/input_text_custom.dart';
import 'package:localdaily/widgets/ld_appbar.dart';
import 'package:localdaily/widgets/ld_footer.dart';
import 'package:localdaily/widgets/primary_button.dart';
import 'package:localdaily/widgets/progress_indicator_local_d.dart';
import 'package:provider/provider.dart';

import '../detail_offer_buy_view_model.dart';

part 'components/card_detail_offer.dart';

part 'detail_offer_buy_mobile.dart';

part 'detail_offer_buy_web.dart';

class DetailOfferBuyView extends StatelessWidget {
  const DetailOfferBuyView({
    Key? key,
    this.isBuy = false,
    this.item,
  }) : super(key: key);

  final bool isBuy;
  final Data? item;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ChangeNotifierProvider<DetailOfferBuyViewModel>(
      create: (_) => DetailOfferBuyViewModel(
          locator<LdRouter>(), locator<ServiceInteractor>(), item!),
      builder: (BuildContext context, _) {
        return _DetailOfferBuyBody(
          isBuy: isBuy,
          item: item!,
        );
      },
    );
  }
}

class _DetailOfferBuyBody extends StatefulWidget {
  const _DetailOfferBuyBody({
    Key? key,
    required this.isBuy,
    required this.item,
  }) : super(key: key);

  final bool isBuy;
  final Data item;

  @override
  _DetailOfferBuyBodyState createState() => _DetailOfferBuyBodyState();
}

class _DetailOfferBuyBodyState extends State<_DetailOfferBuyBody> {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  late StreamSubscription<DetailOfferBuyEffect> _effectSubscription;

  final TextEditingController accountNumCtrl = TextEditingController();
  final TextEditingController docNumCtrl = TextEditingController();
  final TextEditingController nameTitularAccountCtrl = TextEditingController();
  final TextEditingController infoPlusOfferCtrl = TextEditingController();

  @override
  void initState() {
    final DetailOfferBuyViewModel viewModel =
        context.read<DetailOfferBuyViewModel>();
    final DataUserProvider dataUserProvider = context.read<DataUserProvider>();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<DetailOfferBuyViewModel>().onInit(context);
    });

    _effectSubscription =
        viewModel.effects.listen((DetailOfferBuyEffect event) {
      if (event is ShowSnackbarConnectivityEffect) {
        // TODO: retroalimentaciòn para mostrar falta de conexiòn
        //DlySnackbar.buildConnectivitySnackbar(context, event.message);
      } else if (event is ValidateOfferEffect) {
        if (keyForm.currentState!.validate()) {
          viewModel.reservationPaymentForDly(
            context,
            item: widget.item,
            userCurrent: dataUserProvider.getDataUserLogged!,
          );
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _effectSubscription.cancel();

    accountNumCtrl.dispose();
    docNumCtrl.dispose();
    nameTitularAccountCtrl.dispose();
    infoPlusOfferCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DetailOfferBuyViewModel viewModel =
        context.watch<DetailOfferBuyViewModel>();
    final Widget loading = viewModel.status.isLoading
        ? ProgressIndicatorLocalD()
        : const SizedBox.shrink();

    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        final double maxWidth = constraints.maxWidth;
        return Stack(
          children: <Widget>[
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: maxWidth > 1024
                      ? const _DetailOfferBuyWeb()
                      : _DetailOfferBuyMobile(
                          item: widget.item,
                          keyForm: keyForm,
                          docNumCtrl: docNumCtrl,
                          accountNumCtrl: accountNumCtrl,
                          nameTitularAccountCtrl: nameTitularAccountCtrl,
                          infoPlusOfferCtrl: infoPlusOfferCtrl,
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
