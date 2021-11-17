import 'package:flutter/cupertino.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/registerDataUser/body_register_data_user.dart';
import 'package:localdaily/services/models/registerDataUser/response_register.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/view_model.dart';

import 'register_user_status.dart';

class RegisterUserViewModel extends ViewModel<RegisterUserStatus> {
  late LdRouter _route;
  late ServiceInteractor _interactor;

  RegisterUserViewModel({
    LdRouter? route,
    ServiceInteractor? interactor,
  }) {
    _route = route ?? locator<LdRouter>();
    _interactor = interactor ?? locator<ServiceInteractor>();

    status = RegisterUserStatus(isLoading: false, isError: false);
  }

  Future<void> onInit({bool validateNotification = false}) async {}

  void goHome(BuildContext context) {
    LdConnection.validateConnection().then((bool value) {
      if (value) {
        _route.goHome(context);
      } else {
        // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
      }
    });
  }

  void goValidateEmail(BuildContext context) {
    LdConnection.validateConnection().then((bool value) {
      if (value) {
        _route.goValidateEmail(context);
      } else {
        // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
      }
    });
  }

  void goRegisterPersonalData(BuildContext context) {
    LdConnection.validateConnection().then((bool value) {
      if (value) {
        _route.goPersonalInfoRegister(context);
      } else {
        // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
      }
    });
  }

  Future<void> registerUser(
    BuildContext context,
    // String email, String password
  ) async {
    status = status.copyWith(isLoading: true);

    final BodyRegisterDataUser bodyRegister = BodyRegisterDataUser(
      nickName: 'e',
      secondName: 'e',
      secondLastName: 'w',
      firstLastName: 'e',
      password: 'z',
      phone: 'e',
      userTypeId: '9c2f4526-5933-4404-96fc-784a87a7b674',
      email: 's',
      firstName: 's',
      dateBirth: '1985/10/25',
      isActive: true,
    );

    try {
      final ResponseData<ResponseRegister> response =
          await _interactor.postRegisterUser(bodyRegister);
      print('RegisterUser Res: ${response.statusCode} ');

      if (response.isSuccess) {
        _route.goHome(context);
      } else {
        // TODO: Mostrar alerta
      }
    } catch (err) {
      print('Login Error As: ${err}');
    }
    status = status.copyWith(isLoading: false);
  }
}
