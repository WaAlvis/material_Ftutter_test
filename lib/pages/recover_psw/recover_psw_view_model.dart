import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/recover_psw/recover_psw_effect.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/recover_psw/body_recover_psw.dart';
import 'package:localdaily/services/models/recover_psw/result_recover_psw.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/view_model.dart';
import 'package:string_validator/string_validator.dart';

import 'recover_psw_status.dart';

class RecoverPswViewModel extends EffectsViewModel<RecoverPswStatus,RecoverPswEffect> {
  late LdRouter _route;
  late ServiceInteractor _interactor;

  RecoverPswViewModel({
    LdRouter? route,
    ServiceInteractor? interactor,
  }) {
    _route = route ?? locator<LdRouter>();
    _interactor = interactor ?? locator<ServiceInteractor>();

    status = RecoverPswStatus(
      isLoading: false,
      isError: false,
      isEmailFieldEmpty: true,
    );
  }

  Future<void> onInit({
    bool validateNotification = false,
  }) async {}

  void changeEmail(String email) =>
      status = status.copyWith(isEmailFieldEmpty: email.isEmpty);

  void requestNewPsw(BuildContext context, String email) {
    LdConnection.validateConnection().then((bool isConnectionValid) {
      if (isConnectionValid) {
        getNewPsw(context, email);
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
  }

  Future<void> getNewPsw(
    BuildContext context,
    String emailUser,
  ) async {
    status = status.copyWith(isLoading: true);

    final BodyRecoverPsw bodyRecoverPsw = BodyRecoverPsw(
      filter: emailUser,
      document: '',
      signature:
          'T2CswFciHcSgFxh8LKRYLuz2dqwuzSCWnat/KRxACqdJhr3aLJBWObPmVyUaE6xtpAca+F1r0F06M4eh2pv6IOUcQueMO7+IRq8Kym8Py48Exu13nOcMkJhoz+o5+alZz7wuHLaAE822PCdnMkEls651+DimZ9qe16SpYVyoisU+P16jUkWBNZ/YVP3xLSNn5yUUK9paYyrKkvviNhlUKcBK0ptu5BS8edadgTXs5PRvYOP7wNp/y8RGgXRfnvNEh6as2xjjvizhEIC0GLywT9MYt/VDCXHZDk+8mpN7wVv6qn6MHEzZw6Gw1q5ObxlGTn67Ap48GjHicLYb1w5fGw==',
      codeLang: 'es',
    );

    _interactor
        .requestPsw(bodyRecoverPsw)
        .then((ResponseData<ResultRecoverPsw> response) {
      if (response.isSuccess) {
        print('NewPsw EXITOSO!!');
        addEffect(ShowSnackbarRecoverPswEffect());
        _route.goLogin(context);
      } else {
        // TODO: Mostrar alerta
        addEffect(ShowSnackbarErrorEmailEffect('error EN el envio'));
        status = status.copyWith(isError: true, isLoading: false );
      }
    }).catchError((err) {
      // status = status.copyWith(isLoading: false, isError: true);
      print('NewPsw Error As: ${err}');
    });
  }

  String? validatorEmail(String? email) {
    {
      if (email == null || email.isEmpty) {
        return '* Campo necesario';
      } else if (!isEmail(email)) {
        return '* Debe ser un correo';
      }
      return null;
    }
  }

}
