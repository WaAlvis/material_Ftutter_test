import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/profile_seller/profile_seller_effect.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/info_user_publish/body_info_user_publish.dart';
import 'package:localdaily/services/models/info_user_publish/response/result_info_user_publish.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/view_model.dart';

import 'profile_seller_status.dart';

class ProfileSellerViewModel
    extends EffectsViewModel<ProfileSellerStatus, ProfileSellerEffect> {
  late LdRouter _route;
  late ServiceInteractor _interactor;
  late String idUser;

  ProfileSellerViewModel(
    this.idUser, {
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
  }) async {
    await getInfoUserPublish(idUser);
  }

  Future<void> getInfoUserPublish(String idUSer) async {
    status = status.copyWith(isLoading: true);

    final BodyInfoUserPublish bodyInfoUserPublish =
        BodyInfoUserPublish(id: idUser);

    _interactor
        .getInfoUserPublish(bodyInfoUserPublish)
        .then((ResponseData<ResultInfoUserPublish> response) {
      if (response.isSuccess) {
        status = status.copyWith(infoUserPublish: response.result, );
      } else {
        //Add effect NOT success
      }
    }).catchError((Object err) {
      print('Info User Publish Error As: $err');
    });
    status = status.copyWith(isLoading: false);
  }

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
