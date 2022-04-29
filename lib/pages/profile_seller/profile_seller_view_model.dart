import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/profile_seller/profile_seller_effect.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/view_model.dart';

import 'profile_seller_status.dart';

class ProfileSellerViewModel
    extends EffectsViewModel<ProfileSellerStatus, ProfileSellerEffect> {
  late LdRouter _route;
  late ServiceInteractor _interactor;

  ProfileSellerViewModel({
    LdRouter? route,
    ServiceInteractor? interactor,
  }) {
    _route = route ?? locator<LdRouter>();
    _interactor = interactor ?? locator<ServiceInteractor>();

    status = ProfileSellerStatus(
      isLoading: false,
      isError: false,
    );
  }

  Future<void> onInit({
    bool validateNotification = false,
  }) async {}

  //Register

  void goRegister(BuildContext context) {
    LdConnection.validateConnection().then((bool isConnectionValid) {
      if (isConnectionValid) {
        _route.goEmailRegister(context);
      } else {
        // addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
  }
}
