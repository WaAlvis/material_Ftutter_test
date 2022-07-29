import 'package:flutter/material.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/profile_seller/profile_seller_effect.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/info_user_publish/body_info_user_publish.dart';
import 'package:localdaily/services/models/info_user_publish/response/result_info_user_publish.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/view_model.dart';
import 'package:provider/provider.dart';

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

  Future<void> onInit(BuildContext context) async {
    getInfoUserPublish(idUser, context);
  }

  void seeMoreOffers() {
    LdConnection.validateConnection().then((bool isConnectionValid) {
      if (isConnectionValid) {
        addEffect(
          ShowSnackbarSeviceIncompleteEffect(
            'Aun seguimos trabajando en este servicio',
          ),
        );
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
  }

  void getInfoUserPublish(String idUser, BuildContext context) {
    LdConnection.validateConnection().then((bool isConnectionValid) {
      if (isConnectionValid) {
        getInfoUser(idUser, context);
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
  }

  Future<void> getInfoUser(String idUSer, BuildContext context) async {
    status = status.copyWith(isLoading: true);

    final BodyInfoUserPublish bodyInfoUserPublish =
        BodyInfoUserPublish(id: idUser);
    final DataUserProvider dataUserProvider = context.read<DataUserProvider>();

    final token = dataUserProvider.getTokenLogin;
    _interactor
        .getInfoUserPublish(bodyInfoUserPublish, 'Bearer ${token!.token}')
        .then((ResponseData<ResultInfoUserPublish> response) {
      if (response.isSuccess) {
        print('@@@ ${response.result?.toJson()}');
        status = status.copyWith(
          infoUserPublish: response.result,
        );
      } else {
        addEffect(ShowErrorSnackbar('Error al cargar los datos'));
      }
      status = status.copyWith(isLoading: false);
    }).catchError((Object err) {
      addEffect(ShowErrorSnackbar('Error en el servicio**'));
      status = status.copyWith(isLoading: false);
    });
  }

  void goHomeForMoreOffers(BuildContext context) {
    LdConnection.validateConnection().then((bool isConnectionValidvalue) {
      if (isConnectionValidvalue) {
        _route.goHome(context);
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
  }
}
