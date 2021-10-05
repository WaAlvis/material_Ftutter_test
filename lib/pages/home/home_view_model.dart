import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:localdaily/api/repository/interactor/api_interactor.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/view_model.dart';
import 'home_status.dart';

class HomeViewModel extends ViewModel<HomeStatus> {

  final LdRouter _route;
  final ApiInteractor _interactor;

  HomeViewModel(this._route, this._interactor) {
    status = HomeStatus(isLoading: false, isError: false);
  }

  Future<void> onInit({bool validateNotification = false}) async {}

  Future<void> goLoginPhone(BuildContext context) async {
    final bool next = await validateConnection();
    if (next) {
      _route.goHome(context);
    } else {
      // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
    }
  }

  Future<bool> validateConnection() async {
    final ConnectivityResult connectivityResult =
      await Connectivity().checkConnectivity();

    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }
}
