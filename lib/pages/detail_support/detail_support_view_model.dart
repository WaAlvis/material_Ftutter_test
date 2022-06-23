import 'package:flutter/cupertino.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/detail_support/detail_support_effect.dart';
import 'package:localdaily/pages/detail_support/ui/detail_support_view.dart';

import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/contact_support/body_contact_support.dart';
import 'package:localdaily/view_model.dart';

import 'detail_support_status.dart';

class DetailSupportViewModel
    extends EffectsViewModel<DetailSupportStatus, DetailSupportEffect> {
  final LdRouter _route;
  final ServiceInteractor _interactor;
  final BodyContactSupport advertisement;

  DetailSupportViewModel(
    this._route,
    this._interactor,
    this.advertisement,
  ) {
    status = DetailSupportStatus(
      isLoading: true,
      isError: false,
    );
  }

  Future<void> onInit() async {}

  void goBack(BuildContext context) {
    _route.pop(context);
  }



  // void goDirectionWallet(BuildContext context) {
  //   LdConnection.validateConnection().then((bool isConnectionValid) {
  //     if (isConnectionValid) {
  //       // _route.goDitectionWallet(context);
  //     } else {
  //       addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
  //     }
  //   });
  // }
}
