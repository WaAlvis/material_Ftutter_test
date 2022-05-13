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
  late String nickName;

  ProfileSellerViewModel(
    this.idUser,
    this.nickName, {
    LdRouter? route,
    ServiceInteractor? interactor,
  }) {
    _route = route ?? locator<LdRouter>();
    _interactor = interactor ?? locator<ServiceInteractor>();

    status = ProfileSellerStatus(
      isLoading: true,
      isError: false,
      nickName: nickName,
    );
  }

  Future<void> onInit({
    bool validateNotification = false,
  }) async {
    getInfoUserPublish(idUser);
  }

  void seeMoreOffers() {
    LdConnection.validateConnection().then((bool isConnectionValid) {
      if (isConnectionValid) {
        addEffect(ShowSnackbarSeviceIncompleteEffect(
            'Aun seguimos trabajando en este servicio'));
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
  }

  void getInfoUserPublish(String idUser) {
    LdConnection.validateConnection().then((bool isConnectionValid) {
      if (isConnectionValid) {
        getInfoUser(idUser);
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
  }

  Future<void> getInfoUser(String idUSer) async {
    status = status.copyWith(isLoading: true);

    final BodyInfoUserPublish bodyInfoUserPublish =
        BodyInfoUserPublish(id: idUser);

    _interactor
        .getInfoUserPublish(bodyInfoUserPublish)
        .then((ResponseData<ResultInfoUserPublish> response) {
      if (response.isSuccess) {
        status = status.copyWith(
          infoUserPublish: response.result,
        );
      } else {
        addEffect(ShowErrorSnackbar('Error al cargar los datos'));
      }
      status = status.copyWith(isLoading: false);
    }).catchError((Object err) {
      addEffect(ShowErrorSnackbar('Error en el servicio**'));
    });
  }
}
