import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_colors.dart';
import 'package:localdaily/commons/ld_constans.dart';
import 'package:localdaily/commons/ld_enums.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/detail_offer/detail_offer_effect.dart';
import 'package:localdaily/providers/configuration_provider.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/create_offers/get_account_type/account_type.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/bank.dart';
import 'package:localdaily/services/models/create_offers/get_doc_type/response/doc_type.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/advertisement.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/data.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/user_data_home.dart';
import 'package:localdaily/services/models/login/get_by_id/result_data_user.dart';
import 'package:localdaily/utils/ld_dialog.dart';
import 'package:localdaily/utils/ld_snackbar.dart';
import 'package:localdaily/utils/values_format.dart';
import 'package:localdaily/widgets/appbar_circles.dart';
import 'package:localdaily/widgets/dropdown_custom.dart';
import 'package:localdaily/widgets/input_text_custom.dart';
import 'package:localdaily/widgets/ld_appbar.dart';
import 'package:localdaily/widgets/ld_footer.dart';
import 'package:localdaily/widgets/primary_button.dart';
import 'package:localdaily/widgets/progress_indicator_local_d.dart';
import 'package:provider/provider.dart';

import '../detail_offer_view_model.dart';

part 'components/card_detail_offer.dart';

part 'detail_offer_mobile.dart';

part 'detail_offer_web.dart';

class DetailOfferView extends StatelessWidget {
  const DetailOfferView({
    Key? key,
    this.isBuy = false,
    this.item,
  }) : super(key: key);

  final bool isBuy;
  final Data? item;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ChangeNotifierProvider<DetailOfferViewModel>(
      create: (_) => DetailOfferViewModel(
        locator<LdRouter>(),
        locator<ServiceInteractor>(),
        item!,
        isBuy: isBuy,
      ),
      builder: (BuildContext context, _) {
        return _DetailOfferBody(
          isBuy: isBuy,
          item: item!,
        );
      },
    );
  }
}

class _DetailOfferBody extends StatefulWidget {
  const _DetailOfferBody({
    Key? key,
    required this.isBuy,
    required this.item,
  }) : super(key: key);

  final bool isBuy;
  final Data item;

  @override
  _DetailOfferBodyState createState() => _DetailOfferBodyState();
}

class _DetailOfferBodyState extends State<_DetailOfferBody> {
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  late StreamSubscription<DetailOfferEffect> _effectSubscription;

  final TextEditingController accountNumCtrl = TextEditingController();
  final TextEditingController docNumCtrl = TextEditingController();
  final TextEditingController nameTitularAccountCtrl = TextEditingController();

  @override
  void initState() {
    final DetailOfferViewModel viewModel = context.read<DetailOfferViewModel>();
    final DataUserProvider dataUserProvider = context.read<DataUserProvider>();
    final ConfigurationProvider configurationProvider =
        context.read<ConfigurationProvider>();

    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => viewModel.onInit(context, configurationProvider),
    );

    _effectSubscription = viewModel.effects.listen((DetailOfferEffect event) {
      if (event is ShowSnackbarConnectivityEffect) {
        LdSnackbar.buildConnectivitySnackbar(context, event.message);
      } else if (event is ValidateOfferEffect) {
        if (keyForm.currentState!.validate()) {
          confirmBottomSheet(
            context,
            Theme.of(context).textTheme,
            widget.item,
            viewModel,
            dataUserProvider.getDataUserLogged!,
            dataUserProvider,
            accountNumCtrl.text,
            docNumCtrl.text,
            nameTitularAccountCtrl.text,
            isBuy: widget.isBuy,
          );
        }
      } else if (event is ShowSnackbarSuccesEffect) {
        LdSnackbar.buildSuccessSnackbar(
          context,
          'Se reservó exitosamente la oferta de ${widget.isBuy ? 'venta' : 'compra'}',
        );
      } else if (event is ShowSnackbarErrorEffect) {
        LdSnackbar.buildErrorSnackbar(context, event.message);
      } else if (event is ConfirmOfferEffect) {
        LdDialog.buildDenseAlertDialog(
          context,
          image: LdAssets.cardConfirm,
          title: 'Confirmar la ${widget.isBuy ? 'venta' : 'compra'}',
          message: widget.isBuy
              ? 'Reservaremos esta oferta de venta. Recuerda revisar tu cuenta bancaria para confirmar el pago.\n\nSi luego quieres cancelar la compra el sistema te restará una estrella de la calificación general de usuario.\n\n¿Quieres confirmar la venta?'
              : 'Reservaremos esta oferta de compra. Realiza tu pago y adjunta el comprobante antes de 12 horas.\n\nSi luego quieres cancelar la compra el sistema te restará una estrella de la calificación general de usuario.\n\n¿Quieres confirmar la compra?',
          btnText: 'Sí, confirmar',
          onTap: event.action,
          btnTextSecondary: 'No, cancelar',
          onTapSecondary: () => viewModel.closeDialog(context),
        );
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DetailOfferViewModel viewModel =
        context.watch<DetailOfferViewModel>();
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
                      ? const _DetailOfferWeb()
                      : _DetailOfferMobile(
                          item: widget.item,
                          keyForm: keyForm,
                          docNumCtrl: docNumCtrl,
                          accountNumCtrl: accountNumCtrl,
                          nameTitularAccountCtrl: nameTitularAccountCtrl,
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
