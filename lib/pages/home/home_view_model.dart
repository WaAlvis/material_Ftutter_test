import 'package:flutter/cupertino.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/services/models/home/body_home.dart';
import 'package:localdaily/services/models/home/pagination.dart';
import 'package:localdaily/services/models/home/reponse/result_home.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/view_model.dart';
import 'home_status.dart';

class HomeViewModel extends ViewModel<HomeStatus> {
  final LdRouter _route;
  final ServiceInteractor _interactor;

  HomeViewModel(this._route, this._interactor) {
    status = HomeStatus(isLoading: false, isError: false);
  }

  Future<void> onInit({bool validateNotification = false}) async {}

  void goLogin(BuildContext context) {
    LdConnection.validateConnection().then((bool value) {
      if (value) {
        _route.goLogin(context);
      } else {
        // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
      }
    });
  }

  Future<void> dataHome(BuildContext context,) async {
    status = status.copyWith(isLoading: true);
    LdConnection.validateConnection().then(
          (bool value) {
        if (value) {
          getDataHome(
            context,
          );
        } else {
          // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
        }
      },
    );
  }

  Future<void> getDataHome(BuildContext context,) async {
    status = status.copyWith(isLoading: true);

    final Pagination pagination = Pagination(
        isPaginable:true, currentPage: 1, itemsPerPage: 10);
    final BodyHome bodyHome = BodyHome(type: 1, pagination: pagination);

    try {
      final ResponseData<ResultHome> response =
      await _interactor.postGetAdvertisment(bodyHome);
      print('HomeData Res: ${response.statusCode} ');
      if (response.isSuccess) {
        print('Exito obteniendo la data de Home');
        _route.goValidateEmail(context);
      } else {
        // TODO: Mostrar alerta
      }
    } catch (err) {
      print('Get DataHome Error As: ${err}');
    }
    status = status.copyWith(isLoading: false);
  }
}
