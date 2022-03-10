import 'package:flutter/cupertino.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/pages/home/ui/home_view.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/home/body_home.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/data.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/result_home.dart';
import 'package:localdaily/services/models/pagination.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/view_model.dart';

import 'home_status.dart';

class HomeViewModel extends ViewModel<HomeStatus> {
  final LdRouter _route;
  final ServiceInteractor _interactor;

  HomeViewModel(this._route, this._interactor) {
    status = HomeStatus(
      hideWallet: false,
      hideValues: false,
      isError: false,
      offersBuyDataHome: ResultHome(
        data: <Data>[],
        totalItems: 10,
        totalPages: 1,
      ),
      offersSaleDataHome: ResultHome(
        data: <Data>[],
        totalItems: 10,
        totalPages: 1,
      ),
      indexTab: 0,
      typeOffer: TypeOffer.sell,
      image: LdAssets.buyNoOffer,
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

  void swapType(TypeOffer type) {
    switch (type) {
      case TypeOffer.sell:
        status = status.copyWith(
          image: LdAssets.saleNoOffer,
          titleText: 'Aun no tienes ofertas de venta',
          buttonText: 'Crear oferta de venta',
        );
        break;
      case TypeOffer.buy:
        status = status.copyWith(
          image: LdAssets.buyNoOffer,
          titleText: 'Aun no tienes ofertas de compra',
          buttonText: 'Crear oferta de compra',
        );
        break;
    }
  }

  void goCreateOffer(BuildContext context, TypeOffer type) {
    LdConnection.validateConnection().then((bool isConnectionValidvalue) {
      if (isConnectionValidvalue) {
        _route.goCreateOffer(context, type);
      } else {
        // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
      }
    });
  }

  void goLogin(BuildContext context) {
    LdConnection.validateConnection().then((bool isConnectionValidvalue) {
      if (isConnectionValidvalue) {
        _route.goLogin(context);
      } else {
        // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
      }
    });
  }

  void goDetailOffer(BuildContext context, {required Data item}) {
    LdConnection.validateConnection().then((bool isConnectionValidvalue) {
      if (isConnectionValidvalue) {
        _route.goDetailOffer(context, item);
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
          getDataHome(context, TypeOffer.buy);
          getDataHome(context, TypeOffer.sell);
        } else {
          // addEffect(ShowSnackbarConnectivityEffect(i18n.noConnection));
        }
      },
    );
  }

  Future<void> getDataHome(BuildContext context, TypeOffer type) async {
    status = status.copyWith(isLoading: true);

    final Pagination pagination =
        Pagination(isPaginable: true, currentPage: 1, itemsPerPage: 10);
    final BodyHome bodyBuyersHome = BodyHome(
      type: type == TypeOffer.buy ? 0 : 1,
      pagination: pagination,
    );

    try {
      final ResponseData<ResultHome> response =
          await _interactor.postGetHomeBuyerSellers(bodyBuyersHome);
      print('HomeData Res: ${response.statusCode} ');
      if (response.isSuccess) {
        print('Exito obteniendo la data de venta en Home');
        if (type == TypeOffer.buy) {
          status.offersSaleDataHome = response.result!;
        } else {
          status.offersBuyDataHome = response.result!;
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
