import 'package:flutter/cupertino.dart';
import 'package:localdaily/api/repository/interactor/api_interactor.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/view_model.dart';
import 'personal_info_register_status.dart';

class PersonalInfoRegisterViewModel extends ViewModel<PersonalInfoRegisterStatus> {

  final LdRouter _route;
  final ApiInteractor _interactor;

  PersonalInfoRegisterViewModel(this._route, this._interactor) {
    status = PersonalInfoRegisterStatus(isLoading: false, isError: false);
  }

  Future<void> onInit({bool validateNotification = false}) async {}

  void goHome(BuildContext context) {
    LdConnection().validateConnection().then((bool value) {
      if (value) {
        _route.goHome(context);
      } else {
        // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
      }
    });
  }
}
