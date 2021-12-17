import 'package:flutter/cupertino.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/home/ui/home_view.dart';
import 'package:localdaily/services/api_interactor.dart';

import 'package:localdaily/services/models/create_offerts/offert/body_offert.dart';
import 'package:localdaily/services/models/create_offerts/offert/entity.dart';
import 'package:localdaily/services/models/create_offerts/offert/result_create_offert.dart';
import 'package:localdaily/services/models/home/body_home.dart';
import 'package:localdaily/services/models/home/get_offerts/reponse/data.dart';
import 'package:localdaily/services/models/home/get_offerts/reponse/result_home.dart';
import 'package:localdaily/services/models/pagination.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/view_model.dart';
import 'home_status.dart';

class HomeViewModel extends ViewModel<HomeStatus> {
  final LdRouter _route;
  final ServiceInteractor _interactor;

  HomeViewModel(this._route, this._interactor) {
    status = HomeStatus(
      isLoading: false,
      hideWallet: false,
      hideValues: false,
      isError: false,
      sellersDataHome: ResultHome(
        data: <Data>[],
        totalItems: 10,
        totalPages: 1,
      ),
      buyersDataHome: ResultHome(
        data: <Data>[],
        totalItems: 10,
        totalPages: 1,
      ),
      indexTab: 0,
      typeOffert: TypeOffert.sell,
      image: LdAssets.buyNoOffert,
      titleText: 'Aún no tienes ofertas de compra',
      buttonText: 'Crear oferta de compra',
    );
  }

  void onItemTapped(int index) {
    status = status.copyWith(indexTab: index);
  }

  void changeHideWallet() {
    final bool value = status.hideWallet;
    status = status.copyWith(hideWallet: !value);
  }

  void changeHideValues() {
    final bool value = status.hideValues;
    status = status.copyWith(hideValues: !value);
  }

  Future<void> onInit(
    BuildContext context, {
    bool validateNotification = false,
  }) async {
    dataHome(context);
  }

  void swapType(TypeOffert type) {
    switch (type) {
      case TypeOffert.sell:
        status = status.copyWith(
          image: LdAssets.saleNoOffert,
          titleText: 'Aun no tienes ofertas de venta',
          buttonText: 'Crear oferta de venta',
        );
        break;
      case TypeOffert.buy:
        status = status.copyWith(
          image: LdAssets.buyNoOffert,
          titleText: 'Aun no tienes ofertas de compra',
          buttonText: 'Crear oferta de compra',
        );
        break;
    }
  }

  void goCreateOffert(BuildContext context, TypeOffert type) {
    LdConnection.validateConnection().then((bool value) {
      if (value) {
        _route.goCreateOffert(context, type);
      } else {
        // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
      }
    });
  }

  void goLogin(BuildContext context) {
    LdConnection.validateConnection().then((bool value) {
      if (value) {
        _route.goLogin(context);
      } else {
        // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
      }
    });
  }

  Future<void> dataHome(
    BuildContext context,
  ) async {
    status = status.copyWith(isLoading: true);
    LdConnection.validateConnection().then(
      (bool value) {
        if (value) {
          getDataHome(context, 1);
          getDataHome(context, 0);
        } else {
          // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
        }
      },
    );
  }

  Future<void> getDataHome(BuildContext context, int type) async {
    status = status.copyWith(isLoading: true);

    final Pagination pagination =
        Pagination(isPaginable: true, currentPage: 1, itemsPerPage: 10);
    final BodyHome bodyBuyersHome =
        BodyHome(type: type, pagination: pagination);

    try {
      final ResponseData<ResultHome> response =
          await _interactor.postGetHomeBuyerSellers(bodyBuyersHome);
      print('HomeData Res: ${response.statusCode} ');
      if (response.isSuccess) {
        print('Exito obteniendo la data de Buyers en Home');
        if (type == 0) {
          status.buyersDataHome = response.result!;
        } else {
          status.sellersDataHome = response.result!;
        }
      } else {
        print('ERROR obteniendo la data de Home');
        // TODO: Mostrar alerta
      }
    } catch (err) {
      print('Get DataHome Error As: $err');
    }
    status = status.copyWith(isLoading: false);
  }
}
