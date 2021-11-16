import 'package:flutter/cupertino.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/services/models/login/body_login.dart';
import 'package:localdaily/services/models/login/response_login.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/view_model.dart';
import 'login_status.dart';

class LoginViewModel extends ViewModel<LoginStatus> {

  late LdRouter _route;
  late ServiceInteractor _interactor;

  LoginViewModel({
    LdRouter? route,
    ServiceInteractor? interactor,
  }) {
    _route = route ?? locator<LdRouter>();
    _interactor = interactor ?? locator<ServiceInteractor>();

    status = LoginStatus(
      isLoading: false,
      isError: true,
    );
  }

  Future<void> onInit({bool validateNotification = false}) async {}

  void goHome(BuildContext context) {

    LdConnection.validateConnection().then((bool value) {
      if (value) {
        login(context);
        //_route.goHome(context);
      } else {
        // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
      }
    });
  }

  void goRegister(BuildContext context) {
    _route.goEmailRegister(context);
    LdConnection.validateConnection().then((bool value) {
      if (value) {
        _route.goEmailRegister(context);
      } else {
        // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
      }
    });
  }

  Future<void> login(BuildContext context) async {

    status = status.copyWith(isLoading: true);

    final BodyLogin bodyLogin = BodyLogin(
        identity: 'rdg123@hotmail.com',
        password: '12345678',
        signature: 'TCswFciHcSgFxh8LKRYLuz2dqwuzSCWnat/KRxACqdJhr3aLJBWObPmVyUaE6xtpAca+F1r0F06M4eh2pv6IOUcQueMO7+IRq8Kym8Py48Exu13nOcMkJhoz+o5+alZz7wuHLaAE822PCdnMkEls651+DimZ9qe16SpYVyoisU+P16jUkWBNZ/YVP3xLSNn5yUUK9paYyrKkvviNhlUKcBK0ptu5BS8edadgTXs5PRvYOP7wNp/y8RGgXRfnvNEh6as2xjjvizhEIC0GLywT9MYt/VDCXHZDk+8mpN7wVv6qn6MHEzZw6Gw1q5ObxlGTn67Ap48GjHicLYb1w5fGw==',
        wearableId: 'a2245936-54fa-411d-91f0-cfc71cd60bc0',
    );

    try{
      final ResponseData<ResponseLogin>  response = await _interactor.postLogin(bodyLogin);
      print('Login Res: ${response.statusCode} ');
      if(response.isSuccess){
        _route.goHome(context);
      }else {
        // TODO: Mostrar alerta
      }
    } catch (err){
      print('Login Error As: ${err}');
    }
    status = status.copyWith(isLoading: false);
  }
}
