import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/offer_buy/offer_buy_effect.dart';
import 'package:localdaily/pages/offer_buy/offer_buy_view_model.dart';
import 'package:localdaily/providers/configuration_provider.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/utils/ld_dialog.dart';
import 'package:localdaily/widgets/appbar_circles.dart';
import 'package:localdaily/widgets/formatters_input_custom.dart';
import 'package:localdaily/widgets/input_text_custom.dart';
import 'package:localdaily/widgets/ld_appbar.dart';
import 'package:localdaily/widgets/ld_footer.dart';
import 'package:localdaily/widgets/primary_button.dart';
import 'package:localdaily/widgets/progress_indicator_local_d.dart';
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
  late StreamSubscription<OfferBuyEffect> _effectSubscription;

  //final TextEditingController usuarioCtrl = TextEditingController();

  @override
  void dispose() {
    marginCtrl.dispose();
    amountDLYCtrl.dispose();
    infoPlusOfferCtrl.dispose();
    focusDLYCOP.dispose();
    cancelSecretCtrl.dispose();
    _effectSubscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    final OfferBuyViewModel viewModel = context.read<OfferBuyViewModel>();
    final DataUserProvider dataUserProvider = context.read<DataUserProvider>();
    final ConfigurationProvider configProvider =
        context.read<ConfigurationProvider>();

    focusDLYCOP = FocusNode();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<OfferBuyViewModel>().onInit(context);
    });

    _effectSubscription = viewModel.effects.listen((OfferBuyEffect event) {
      if (event is ShowSnackbarConnectivityEffect) {
        // TODO: retroalimentaciòn para mostrar falta de conexiòn
        //DlySnackbar.buildConnectivitySnackbar(context, event.message);
      } else if (event is ValidateOfferEffect) {
        if (keyForm.currentState!.validate()) {
          LdDialog.buildDenseAlertDialog(
            context,
            image: LdAssets.createOffer,
            title: 'Publicar oferta',
            message:
                'Tu publicación estará visible por 7 días, pasado este tiempo la publicación no estará disponible.\n\n¿Quiéres publicar la oferta de compra?',
            btnText: 'Si, publicar',
            onTap: () => viewModel.createOfferBuy(
              context,
              dataUserProvider,
              configProvider.getResultTypeOffer!,
              margin: marginCtrl.text,
              amountDLY: amountDLYCtrl.text,
              infoPlusOffer: infoPlusOfferCtrl.text,
              userId: dataUserProvider.getDataUserLogged!.id,
              wordSecret: cancelSecretCtrl.text,
            ),
            btnTextSecondary: 'Cancelar',
            onTapSecondary: () => viewModel.closeDialog(context),
          );
        }
      }
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
              physics: const BouncingScrollPhysics(),
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
