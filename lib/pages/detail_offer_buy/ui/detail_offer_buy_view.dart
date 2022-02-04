import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/data.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/data.dart';
import 'package:localdaily/widgets/input_text_custom.dart';
import 'package:localdaily/widgets/ld_appbar.dart';
import 'package:localdaily/widgets/ld_footer.dart';
import 'package:localdaily/widgets/primary_button.dart';
import 'package:localdaily/widgets/progress_indicator_local_d.dart';
import 'package:localdaily/widgets/quarter_circle.dart';
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
        locator<LdRouter>(),
        locator<ServiceInteractor>(),
        item!
      ),
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
  final TextEditingController secretWordCtrl = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<DetailOfferBuyViewModel>().onInit(context);
    });
    super.initState();
  }

  @override
  void dispose() {
    secretWordCtrl.dispose();
    // TODO: implement dispose
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
              slivers: <Widget>[
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: maxWidth > 1024
                      ? const _DetailOfferBuyWeb()
                      : _DetailOfferBuyMobile(
                          item: widget.item,
                          keyForm: keyForm,
                          secretWordCtrl: secretWordCtrl,
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
