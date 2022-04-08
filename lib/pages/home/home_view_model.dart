import 'package:flutter/cupertino.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_enums.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/configure/local_storage_service.dart';
import 'package:localdaily/pages/home/home_effect.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/home/body_home.dart';
import 'package:localdaily/services/models/home/filters.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/data.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/result_home.dart';
import 'package:localdaily/services/models/login/get_by_id/result_data_user.dart';
import 'package:localdaily/services/models/pagination.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:localdaily/utils/crypto_utils.dart';
import 'package:localdaily/utils/midaily_connect.dart';
import 'package:localdaily/view_model.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home_status.dart';

class HomeViewModel extends EffectsViewModel<HomeStatus, HomeEffect> {
  final LdRouter _route;
  final ServiceInteractor _interactor;
  final int itemsPerPage = 10;
  late LocalStorageService _localStorage;

  HomeViewModel(this._route, this._interactor, this._localStorage) {
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
      operationBuyData: ResultHome(
        data: <Data>[],
        totalItems: 10,
        totalPages: 1,
      ),
      operationSaleData: ResultHome(
        data: <Data>[],
        totalItems: 10,
        totalPages: 1,
      ),
      myOfferBuyData: ResultHome(
        data: <Data>[],
        totalItems: 10,
        totalPages: 1,
      ),
      myOfferSaleData: ResultHome(
        data: <Data>[],
        totalItems: 10,
        totalPages: 1,
      ),
      indexTab: 0,
      typeOffer: TypeOffer.buy,
      image: LdAssets.buyNoOffer,
      titleText: 'Aún no tienes ofertas de compra',
      buttonText: 'Crear oferta de compra',
      balance: -1,
    );
  }

  Future<void> onItemTapped(
    int index,
    String address,
  ) async {
    status = status.copyWith(indexTab: index);
    if (index == 3) {
      status = status.copyWith(
        balance: await CryptoUtils().getBalance(address),
      );
    }
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
    BuildContext context,
    DataUserProvider userProvider,
    ResultDataUser? resultDataUser, {
    bool validateNotification = false,
  }) async {
    getData(context, resultDataUser?.id ?? '');
    if (resultDataUser == null) return;

    // Se trae el address en caso de que sea el mismo en BD que en LocalStorage
    if (resultDataUser.addressWallet ==
        _localStorage.getPreferences()!.getString(resultDataUser.email)) {
      userProvider.setAddress(resultDataUser.addressWallet);
    }
    status = status.copyWith(resultDataUser: resultDataUser);
  }

  Future<void> swapType(
    BuildContext context,
    TypeOffer type,
    String userId,
  ) async {
    status = status.copyWith(typeOffer: type);
    await getData(context, userId);
    /* switch (type) {
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
    } */
  }

  Future<void> launchWeb(SocialNetwork type) async {
    const String instagramUrl = 'https://www.instagram.com/local.daily_/';
    const String twitterUrl = 'https://twitter.com/';
    const String facebookUrl = 'https://es-la.facebook.com/';
    final String url;
    switch (type) {
      case SocialNetwork.facebook:
        url = facebookUrl;
        break;
      case SocialNetwork.instagram:
        url = instagramUrl;
        break;
      case SocialNetwork.twitter:
        url = twitterUrl;
        break;
    }
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
    // can't launch url, there is some error
  }

  void goHistoryOperations(BuildContext context) {
    LdConnection.validateConnection().then((bool isConnectionValid) {
      if (isConnectionValid) {
        _route.goHistoryOperations(context);
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
  }

  void goSettings(BuildContext context) {
    LdConnection.validateConnection().then((bool isConnectionValid) {
      if (isConnectionValid) {
        _route.goSettings(context);
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
  }

  void logoutUser(BuildContext context) {
    LdConnection.validateConnection().then((bool isConnectionValid) {
      if (isConnectionValid) {
        status = status.copyWith(resultDataUser: null);
        _route.goLoginForLogout(context);
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
  }

  void goCreateOffer(BuildContext context) {
    LdConnection.validateConnection().then((bool isConnectionValidvalue) {
      if (isConnectionValidvalue) {
        _route.goCreateOffer(context, status.typeOffer);
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
  }

  void goLogin(BuildContext context) {
    LdConnection.validateConnection().then((bool isConnectionValidvalue) {
      if (isConnectionValidvalue) {
        _route.goLogin(context);
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
  }

  void goDetailOffer(
    BuildContext context, {
    required Data item,
    bool isBuy = false,
  }) {
    LdConnection.validateConnection().then((bool isConnectionValidvalue) {
      if (isConnectionValidvalue) {
        _route.goDetailOffer(context, item, isBuy: isBuy);
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
  }

  void disconnectWallet() {
    LdConnection.validateConnection().then((bool isConnectionValid) {
      if (isConnectionValid) {
        addEffect(ShowDialogHomeEffect());
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
  }

  void handleDisconnect(
    BuildContext context,
    String email,
    DataUserProvider userProvider,
  ) {
    _route.pop(context);
    MiDailyConnect.removeAddress(context, email, userProvider);
    addEffect(ShowSnackbarDisconnect());
  }

  void closeDialog(BuildContext context) {
    _route.pop(context);
  }

  Future<void> getData(
    BuildContext context,
    String userId, {
    bool refresh = false,
  }) async {
    final bool next = await LdConnection.validateConnection();
    if (next) {
      if (status.indexTab == 0) {
        await getDataHome(context, userId, refresh: refresh);
      } else if (status.indexTab == 1) {
        if (userId.isNotEmpty)
          await getDataOperations(context, userId, refresh: refresh);
      } else if (status.indexTab == 2) {
        if (userId.isNotEmpty)
          await getDataOffers(context, userId, refresh: refresh);
      }
    } else {
      addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
    }
    status = status.copyWith(isLoading: false);
  }

  // ------ CONSULTA PARA TRAER TARJETAS DEL INICIO ------
  Future<void> getDataHome(
    BuildContext context,
    String userId, {
    bool refresh = false,
  }) async {
    // TODO: Validar esta condiciòn para cuando sea paginable
    if (!refresh) {
      if (status.typeOffer == TypeOffer.buy) {
        if (status.offersSaleDataHome.data.isNotEmpty ||
            status.offersSaleDataHome.totalItems ==
                status.offersSaleDataHome.data.length) return;
      } else {
        if (status.offersBuyDataHome.data.isNotEmpty ||
            status.offersBuyDataHome.totalItems ==
                status.offersBuyDataHome.data.length) return;
      }
    }

    status = status.copyWith(isLoading: true);

    // TODO: REALIZAR LA PAGINACIÒN EN LAS 3 CONSULTAS
    final Pagination pagination = Pagination(
      isPaginable: false,
      currentPage: status.typeOffer == TypeOffer.buy
          ? status.offersBuyDataHome.data.length ~/ itemsPerPage
          : status.offersSaleDataHome.data.length ~/ itemsPerPage,
      itemsPerPage: itemsPerPage,
    );

    final Filters filters = Filters(
      typeAdvertisement: status.typeOffer == TypeOffer.buy ? '0' : '1',
      idUserPublish: '',
      statusCode: '0',
      idUserExclusion: userId,
      idUserInteraction: '',
    );

    final BodyHome body = BodyHome(
      pagination: pagination,
      filters: filters,
    );

    try {
      final ResponseData<ResultHome> response =
          await _interactor.postGetAdvertisementByFilters(body);
      if (response.isSuccess) {
        if (status.typeOffer == TypeOffer.buy) {
          status = status.copyWith(offersSaleDataHome: response.result);
        } else {
          status = status.copyWith(offersBuyDataHome: response.result);
        }
      } else {
        print('ERROR obteniendo la data de Home');
        // TODO: Mostrar alerta
      }
    } catch (err) {
      print('Get DataHome Error As: $err');
    }
  }

  // ------ CONSULTA PARA TRAER TARJETAS DE OPERACIONES ------
  Future<void> getDataOperations(
    BuildContext context,
    String userId, {
    bool refresh = false,
  }) async {
    if (!refresh) {
      if (status.typeOffer == TypeOffer.buy) {
        if (status.operationSaleData.data.isNotEmpty ||
            status.operationSaleData.totalItems ==
                status.operationSaleData.data.length) return;
      } else {
        if (status.operationBuyData.data.isNotEmpty ||
            status.operationBuyData.totalItems ==
                status.operationBuyData.data.length) return;
      }
    }

    status = status.copyWith(isLoading: true);

    final Pagination pagination = Pagination(
      isPaginable: false,
      currentPage: status.typeOffer == TypeOffer.buy
          ? status.operationBuyData.data.length ~/ itemsPerPage
          : status.operationSaleData.data.length ~/ itemsPerPage,
      itemsPerPage: itemsPerPage,
    );

    final Filters filters = Filters(
      typeAdvertisement: status.typeOffer == TypeOffer.buy ? '0' : '1',
      idUserPublish: '',
      statusCode: '1',
      idUserExclusion: '',
      idUserInteraction: userId,
    );

    final BodyHome body = BodyHome(
      pagination: pagination,
      filters: filters,
    );

    try {
      final ResponseData<ResultHome> response =
          await _interactor.postGetAdvertisementByFilters(body);
      if (response.isSuccess) {
        if (status.typeOffer == TypeOffer.buy) {
          status = status.copyWith(operationSaleData: response.result);
        } else {
          status = status.copyWith(operationBuyData: response.result);
        }
      } else {
        print('ERROR obteniendo la data de Home');
        // TODO: Mostrar alerta
      }
    } catch (err) {
      print('Get DataHome Error As: $err');
    }
  }

  // ------ CONSULTA PARA TRAER TARJETAS DE MIS OFERTAS ------
  Future<void> getDataOffers(
    BuildContext context,
    String userId, {
    bool refresh = false,
  }) async {
    if (!refresh) {
      if (status.typeOffer == TypeOffer.buy) {
        if (status.myOfferBuyData.data.isNotEmpty ||
            status.myOfferBuyData.totalItems ==
                status.myOfferBuyData.data.length) return;
      } else {
        if (status.myOfferSaleData.data.isNotEmpty ||
            status.myOfferSaleData.totalItems ==
                status.myOfferSaleData.data.length) return;
      }
    }

    status = status.copyWith(isLoading: true);

    final Pagination pagination = Pagination(
      isPaginable: false,
      currentPage: status.typeOffer == TypeOffer.buy
          ? status.myOfferBuyData.data.length ~/ itemsPerPage
          : status.myOfferSaleData.data.length ~/ itemsPerPage,
      itemsPerPage: itemsPerPage,
    );

    final Filters filters = Filters(
      typeAdvertisement: status.typeOffer == TypeOffer.buy ? '1' : '0',
      idUserPublish: userId,
      statusCode: '',
      idUserExclusion: '',
      idUserInteraction: '',
    );

    final BodyHome body = BodyHome(
      pagination: pagination,
      filters: filters,
    );

    try {
      final ResponseData<ResultHome> response =
          await _interactor.postGetAdvertisementByFilters(body);
      if (response.isSuccess) {
        if (status.typeOffer == TypeOffer.buy) {
          status = status.copyWith(myOfferBuyData: response.result);
        } else {
          status = status.copyWith(myOfferSaleData: response.result);
        }
      } else {
        print('ERROR obteniendo la data de Home');
        // TODO: Mostrar alerta
      }
    } catch (err) {
      print('Get DataHome Error As: $err');
    }
  }
}

enum SocialNetwork { facebook, instagram, twitter }
