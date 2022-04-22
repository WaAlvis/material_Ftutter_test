import 'dart:async';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/commons/ld_enums.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/attached_file/attached_file_view_model.dart';
import 'package:localdaily/pages/detail_offer/ui/detail_offer_view.dart';
import 'package:localdaily/pages/detail_oper_offer/detail_oper_offer_effect.dart';
import 'package:localdaily/pages/home/home_view_model.dart';
import 'package:localdaily/providers/configuration_provider.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/bank.dart';
import 'package:localdaily/services/models/detail_oper_offer/result_get_advertisement.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/advertisement.dart';
import 'package:localdaily/utils/ld_dialog.dart';
import 'package:localdaily/utils/ld_snackbar.dart';
import 'package:localdaily/view_model.dart';
import 'package:localdaily/widgets/appbar_circles.dart';
import 'package:localdaily/widgets/ld_appbar.dart';
import 'package:localdaily/widgets/ld_footer.dart';
import 'package:localdaily/widgets/primary_button.dart';
import 'package:localdaily/widgets/progress_indicator_local_d.dart';
import 'package:provider/provider.dart';

import '../detail_oper_effer_view_model.dart';

part 'components/card_detail_oper_offer.dart';

part 'detail_oper_offer_mobile.dart';

part 'components/operation_header_oper_offer.dart';

part 'components/detail_state_oper_offer.dart';

part 'components/card_support.dart';

part 'components/card_detail_info.dart';

part 'components/detail_pay.dart';

part 'components/card_add_info.dart';

part 'components/card_bank_buy.dart';

part 'components/card_bank_sell.dart';

part 'detail_oper_offer_web.dart';

class DetailOperOfferView extends StatelessWidget {
  const DetailOperOfferView({Key? key, required this.offerId})
      : super(key: key);

  final String offerId;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ChangeNotifierProvider<DetailOperOfferViewModel>(
      create: (_) => DetailOperOfferViewModel(
        locator<LdRouter>(),
        locator<ServiceInteractor>(),
        offerId,
      ),
      builder: (BuildContext context, _) {
        return _DetailOperOfferBody();
      },
    );
  }
}

class _DetailOperOfferBody extends StatefulWidget {
  const _DetailOperOfferBody({
    Key? key,
  }) : super(key: key);

  @override
  State<_DetailOperOfferBody> createState() => __DetailOperOfferBodyState();
}

class __DetailOperOfferBodyState extends State<_DetailOperOfferBody> {
  late StreamSubscription<DetailOperOfferEffect> _effectSubscription;

  @override
  void initState() {
    final DetailOperOfferViewModel viewModel =
        context.read<DetailOperOfferViewModel>();
    final ConfigurationProvider configurationProvider =
        context.read<ConfigurationProvider>();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context
          .read<DetailOperOfferViewModel>()
          .onInit(context, configurationProvider);
    });

    _effectSubscription =
        viewModel.effects.listen((DetailOperOfferEffect event) {
      if (event is ShowSnackConnetivityEffect) {
        LdSnackbar.buildConnectivitySnackbar(context, event.message);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _effectSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DetailOperOfferViewModel viewModel =
        context.watch<DetailOperOfferViewModel>();
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
                      ? const _DetailOperOfferWeb()
                      : _DetailOperOfferMobile(
                          item: 'Prueba',
                          isBuy: true,
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
