import 'package:flutter/cupertino.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/create_offerts/getBanks/response/bank.dart';
import 'package:localdaily/services/models/create_offerts/getBanks/response/result_get_banks.dart';
import 'package:localdaily/services/models/pagination.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/view_model.dart';

import 'offert_sale_status.dart';

class OffertSaleViewModel extends ViewModel<OffertSaleStatus> {
  late LdRouter _route;
  late ServiceInteractor _interactor;

  OffertSaleViewModel({
    LdRouter? route,
    ServiceInteractor? interactor,
  }) {
    _route = route ?? locator<LdRouter>();
    _interactor = interactor ?? locator<ServiceInteractor>();

    status = OffertSaleStatus(
      isLoading: false,
      isError: true,
      listBanks: ResultGetBanks(
        data: <Bank>[],
        totalItems: 10,
        totalPages: 1,
      ),
    );
  }

  Future<void> onInit(
    BuildContext context, {
    bool validateNotification = false,
  }) async {
    getBanks(context);
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

  Future<void> getBanks(BuildContext context) async {
    status = status.copyWith(isLoading: true);

    final Pagination pagination = Pagination(
      isPaginable: true,
      currentPage: 1,
      itemsPerPage: 10,
    );

    try {
      final ResponseData<ResultGetBanks> response =
          await _interactor.getBanks(pagination);
      print('Baks list Res: ${response.statusCode} ');
      if (response.isSuccess) {
        print('Exito obteniendo la data Los BANCOS!!');
        status.listBanks = response.result!;
      } else {
        print('ERROR obteniendo la data de Baks');
        // TODO: Mostrar alerta
      }
    } catch (err) {
      print('Get Banks Error As: $err');
    }
    status = status.copyWith(isLoading: false);
  }

  void goRecoverPassword(BuildContext context) {
    print('Implementar vista de recuperar contrasenia');
    // _route.goEmailRegister(context);
    // LdConnection.validateConnection().then((bool value) {
    //   if (value) {
    //     _route.goEmailRegister(context);
    //   } else {
    //     // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
    //   }
    // });
  }
}
