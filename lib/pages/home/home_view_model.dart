import 'package:flutter/cupertino.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/create_offerts/getBanks/response/bank.dart';
import 'package:localdaily/services/models/create_offerts/getBanks/response/result_get_banks.dart';
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
      listBanks: ResultGetBanks(
        data: <Bank>[],
        totalItems: 10,
        totalPages: 1,
      ),
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
    getBanks(context);
  }

  void goCreateOffertSale(BuildContext context) {
    LdConnection.validateConnection().then((bool value) {
      if (value) {
        _route.goCreateOffertSale(context);
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

  Future<void> postCreateOffert(
    BuildContext context,
    // String email,
    // String password,
  ) async {
    status = status.copyWith(isLoading: true);

    final Entity entity = Entity(
      idTypeAdvertisement: '138412e9-4907-4d18-b432-70bdec7940c4',
      idCountry: '138412e9-4907-4d18-b432-70bdec7940c4',
      valueToSell: '5000',
      margin: '1',
      termsOfTrade: 'solo pagos en la noche',
      idUserPublish: 'ac8c8d30-391e-457a-8c1d-2f3a7d4e81d2',
    );
    final BodyOffert bodyOffert = BodyOffert(
        entity: entity,
        daysOfExpired: 7,
        strJsonAdvertisementBanks:
            '[{\"bankId\": \"249bfcd0-4ab0-49a8-a886-63ce42c919a6\",\"accountNumber\": \"555555555\",\"accountTypeId\": \"c047a07c-2daf-48a7-ad49-ec447a93485b\",\"documentNumber\": \"123456789\",\"titularUserName\": \"Roger Gutierrez\"},{\"bankId\": \"249bfcd0-4ab0-49a8-a886-63ce42c919a6\",\"accountNumber\":\"101010101\",\"accountTypeId\": \"c047a07c-2daf-48a7-ad49-ec447a93485b\",\"documentNumber\": \"987654321\",\"titularUserName\": \"Carmen Martinez\"}]');

    _interactor
        .createOffert(bodyOffert)
        .then((ResponseData<ResultCreateOffert> response) {
      print('Create Offert Res: ${response.statusCode} ');
      if (response.isSuccess) {
        print('Oferta de venta creada EXITOSO!!');

        _route.goHome(context);
      } else {
        // TODO: Mostrar alerta
      }
      status = status.copyWith(isLoading: false);
    }).catchError((err) {
      print('Login Error As: ${err}');
      status = status.copyWith(isLoading: false);
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
      print('HomeData Res: ${response.statusCode} ');
      if (response.isSuccess) {
        print('Exito obteniendo la data Los BANCOS!!');
        status.listBanks = response.result!;
      } else {
        print('ERROR obteniendo la data de Home');
        // TODO: Mostrar alerta
      }
    } catch (err) {
      print('Get DataHome Error As: $err');
    }
    status = status.copyWith(isLoading: false);
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
