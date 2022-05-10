import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:localdaily/commons/ld_assets.dart';
import 'package:localdaily/commons/ld_enums.dart';
import 'package:localdaily/configure/ld_connection.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/configure/local_storage_service.dart';
import 'package:localdaily/pages/filters/ui/filters_view.dart';
import 'package:localdaily/pages/home/home_effect.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/models/home/body_home.dart';
import 'package:localdaily/services/models/home/extra_filters.dart';
import 'package:localdaily/services/models/home/filters.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/data.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/result_home.dart';
import 'package:localdaily/services/models/login/get_by_id/result_data_user.dart';
import 'package:localdaily/services/models/notifications/counter/body_notification_counter.dart';
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
      countNotification: 0,
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
      filtersArguments: FiltersArguments(),
    );
  }

  Future<void> onItemTapped(
    int index,
    String address,
  ) async {
    status = status.copyWith(indexTab: index);
    // status = status.copyWith(
    //     extraFilters: ExtraFilters(
    //         range: null, dateExpiry: null, bank: null, status: null));
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
    if (userProvider.getDataUserLogged != null) {
      getCountNotification(userProvider.getDataUserLogged!.id);
    }
    FiltersArguments filtersArguments = FiltersArguments(
        // extraFilters: status.extraFilters,
        homeStatus: status,
        indexTab: status.indexTab,
        setFilters: (ExtraFilters extraFilters, String extraFiltersString) {
          status = status.copyWith(extraFilters: extraFilters);
          status = status.copyWith(extraFiltersString: extraFiltersString);
          getData(context, resultDataUser?.id ?? '', refresh: true);
        },
        getFilters: <int>() => status.indexTab,
        clearFilters: () {
          status = status.copyWith(
              extraFilters: ExtraFilters(), extraFiltersString: '');
        });
    status = status.copyWith(filtersArguments: filtersArguments);

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
    status = status.copyWith(
        typeOffer: type, extraFiltersString: '', extraFilters: ExtraFilters());
    await getData(context, userId, refresh: true);
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

  void goHistoryOperations(
    BuildContext context,
  ) {
    LdConnection.validateConnection().then((bool isConnectionValid) async {
      if (isConnectionValid) {
        _route.goHistoryOperations(
          context,
        );
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

  void logoutUser(BuildContext context, DataUserProvider userProvider) {
    LdConnection.validateConnection().then((bool isConnectionValid) {
      if (isConnectionValid) {
        status = status.copyWith(resultDataUser: null);
        userProvider.logoutClear();
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

  void goNotifications(BuildContext context) {
    LdConnection.validateConnection().then((bool isConnectionValidvalue) {
      if (isConnectionValidvalue) {
        _route.goNotifications(context);
        //_route.goContactSupport(context);
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

  Future<void> getCountNotification(String userId) async {
    try {
      final BodyNotificationCounter body =
          BodyNotificationCounter(idUser: userId);
      _interactor.getNotificationsUnread(body).then((response) {
        if (response.isSuccess) {
          status = status.copyWith(
            countNotification: response.result!.notificationsUnread,
          );
        }
      });
    } catch (e) {
      print('Error Notification Unread $e');
    }
  }

  void goFiltres(
    BuildContext context,
    // FiltersArguments filtersArguments,
  ) {
    LdConnection.validateConnection().then((bool isConnectionValidvalue) {
      if (isConnectionValidvalue) {
        status = status.copyWith(
            filtersArguments: status.filtersArguments!
                .copyWith(extraFilters: status.extraFilters));
        _route.goFilters(context, status.filtersArguments!);
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
    bool isPagination = false,
  }) async {
    final bool next = await LdConnection.validateConnection();
    if (next) {
      if (status.indexTab == 0) {
        await getDataHome(
          context,
          userId,
          refresh: refresh,
          isPagination: isPagination,
        );
      } else if (status.indexTab == 1) {
        if (userId.isNotEmpty)
          await getDataOperations(
            context,
            userId,
            refresh: refresh,
            isPagination: isPagination,
          );
      } else if (status.indexTab == 2) {
        if (userId.isNotEmpty)
          await getDataOffers(
            context,
            userId,
            refresh: refresh,
            isPagination: isPagination,
          );
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
    bool isPagination = false,
  }) async {
    // Validación para evitar consultar al cambiar cada tab, solo 1 vez
    if (!refresh && !isPagination) {
      if (status.typeOffer == TypeOffer.buy) {
        if (status.offersSaleDataHome.data.isNotEmpty) return;
      } else {
        if (status.offersBuyDataHome.data.isNotEmpty) return;
      }
    }
    if (isPagination) {
      if (status.typeOffer == TypeOffer.buy) {
        if (status.offersSaleDataHome.totalItems ==
            status.offersSaleDataHome.data.length) return;
      } else {
        if (status.offersBuyDataHome.totalItems ==
            status.offersBuyDataHome.data.length) return;
      }
    }

    status = status.copyWith(isLoading: !isPagination);

    int currentPage = 1;
    // Calculo de la pagina actual para realizar paginación a la siguiente página
    if (isPagination) {
      if (status.typeOffer == TypeOffer.buy) {
        if (status.offersSaleDataHome.data.length >= itemsPerPage) {
          currentPage =
              (status.offersSaleDataHome.data.length ~/ itemsPerPage) + 1;
        }
      } else {
        if (status.offersBuyDataHome.data.length >= itemsPerPage) {
          currentPage =
              (status.offersBuyDataHome.data.length ~/ itemsPerPage) + 1;
        }
      }
    }

    // Construcción del body para la consulta
    final Pagination pagination = Pagination(
      isPaginable: true,
      currentPage: currentPage,
      itemsPerPage: itemsPerPage,
    );
    final Filters filters = Filters(
      typeAdvertisement: status.typeOffer == TypeOffer.buy
          ? '${TypeOffer.sell.index}'
          : '${TypeOffer.buy.index}',
      idUserPublish: '',
      statusCode: '${OfferStatus.Publicado.index}',
      idUserExclusion: userId,
      idUserInteraction: '',
      strJsonExtraFilters: status.extraFiltersString ?? '',
    );
    final BodyHome body = BodyHome(
      pagination: pagination,
      filters: filters,
    );

    try {
      // Solicitud al servicio
      final ResponseData<ResultHome> response =
          await _interactor.postGetAdvertisementByFilters(body);
      if (response.isSuccess) {
        final List<Data> data = status.typeOffer == TypeOffer.buy
            ? <Data>[
                ...status.offersSaleDataHome.data,
                ...response.result!.data
              ]
            : <Data>[
                ...status.offersBuyDataHome.data,
                ...response.result!.data
              ];

        if (status.typeOffer == TypeOffer.buy) {
          status = status.copyWith(
            offersSaleDataHome: isPagination
                ? ResultHome(
                    data: data,
                    totalItems: status.offersSaleDataHome.totalItems,
                    totalPages: status.offersSaleDataHome.totalPages,
                  )
                : response.result,
          );
        } else {
          status = status.copyWith(
            offersBuyDataHome: isPagination
                ? ResultHome(
                    data: data,
                    totalItems: status.offersBuyDataHome.totalItems,
                    totalPages: status.offersBuyDataHome.totalPages,
                  )
                : response.result,
          );
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
    bool isPagination = false,
  }) async {
    // Validación para evitar consultar al cambiar cada tab, solo 1 vez
    if (!refresh && !isPagination) {
      if (status.typeOffer == TypeOffer.buy) {
        if (status.operationSaleData.data.isNotEmpty) return;
      } else {
        if (status.operationBuyData.data.isNotEmpty) return;
      }
    }
    if (isPagination) {
      if (status.typeOffer == TypeOffer.buy) {
        if (status.operationSaleData.totalItems ==
            status.operationSaleData.data.length) return;
      } else {
        if (status.operationBuyData.totalItems ==
            status.operationBuyData.data.length) return;
      }
    }

    status = status.copyWith(isLoading: !isPagination);

    int currentPage = 1;
    // Calculo de la pagina actual para realizar paginación a la siguiente página
    if (isPagination) {
      if (status.typeOffer == TypeOffer.buy) {
        if (status.operationSaleData.data.length >= itemsPerPage) {
          currentPage =
              (status.operationSaleData.data.length ~/ itemsPerPage) + 1;
        }
      } else {
        if (status.operationBuyData.data.length >= itemsPerPage) {
          currentPage =
              (status.operationBuyData.data.length ~/ itemsPerPage) + 1;
        }
      }
    }

    // Construcción del body para la consulta
    final Pagination pagination = Pagination(
      isPaginable: true,
      currentPage: currentPage,
      itemsPerPage: itemsPerPage,
    );
    final Filters filters = Filters(
        typeAdvertisement: status.typeOffer == TypeOffer.buy
            ? '${TypeOffer.sell.index}'
            : '${TypeOffer.buy.index}',
        idUserPublish: '',
        statusCode: '${OfferStatus.Pendiente.index}',
        idUserExclusion: '',
        idUserInteraction: userId,
        strJsonExtraFilters: status.extraFiltersString ?? '');
    final BodyHome body = BodyHome(
      pagination: pagination,
      filters: filters,
    );

    try {
      // Solicitud al servicio
      final ResponseData<ResultHome> response =
          await _interactor.postGetAdvertisementByFilters(body);
      if (response.isSuccess) {
        final List<Data> data = status.typeOffer == TypeOffer.buy
            ? <Data>[...status.operationSaleData.data, ...response.result!.data]
            : <Data>[...status.operationBuyData.data, ...response.result!.data];
        if (status.typeOffer == TypeOffer.buy) {
          status = status.copyWith(
            operationSaleData: isPagination
                ? ResultHome(
                    data: data,
                    totalItems: status.operationSaleData.totalItems,
                    totalPages: status.operationSaleData.totalPages,
                  )
                : response.result,
          );
        } else {
          status = status.copyWith(
            operationBuyData: isPagination
                ? ResultHome(
                    data: data,
                    totalItems: status.operationBuyData.totalItems,
                    totalPages: status.operationBuyData.totalPages,
                  )
                : response.result,
          );
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
    bool isPagination = false,
  }) async {
    // Validación para evitar consultar al cambiar cada tab, solo 1 vez
    if (!refresh && !isPagination) {
      if (status.typeOffer == TypeOffer.buy) {
        if (status.myOfferBuyData.data.isNotEmpty) return;
      } else {
        if (status.myOfferSaleData.data.isNotEmpty) return;
      }
    }
    if (isPagination) {
      if (status.typeOffer == TypeOffer.buy) {
        if (status.myOfferBuyData.totalItems ==
            status.myOfferBuyData.data.length) return;
      } else {
        if (status.myOfferSaleData.totalItems ==
            status.myOfferSaleData.data.length) return;
      }
    }

    status = status.copyWith(isLoading: !isPagination);

    int currentPage = 1;
    // Calculo de la pagina actual para realizar paginación a la siguiente página
    if (isPagination) {
      if (status.typeOffer == TypeOffer.buy) {
        if (status.myOfferBuyData.data.length >= itemsPerPage) {
          currentPage = (status.myOfferBuyData.data.length ~/ itemsPerPage) + 1;
        }
      } else {
        if (status.myOfferSaleData.data.length >= itemsPerPage) {
          currentPage =
              (status.myOfferSaleData.data.length ~/ itemsPerPage) + 1;
        }
      }
    }

    // Construcción del body para la consulta
    final Pagination pagination = Pagination(
      isPaginable: true,
      currentPage: currentPage,
      itemsPerPage: itemsPerPage,
    );
    final Filters filters = Filters(
        typeAdvertisement: status.typeOffer == TypeOffer.buy
            ? '${TypeOffer.buy.index}'
            : '${TypeOffer.sell.index}',
        idUserPublish: userId,
        statusCode: '',
        idUserExclusion: '',
        idUserInteraction: '',
        strJsonExtraFilters: status.extraFiltersString ?? '');
    final BodyHome body = BodyHome(
      pagination: pagination,
      filters: filters,
    );
    // Solicitud al servicio
    try {
      final ResponseData<ResultHome> response =
          await _interactor.postGetAdvertisementByFilters(body);
      if (response.isSuccess) {
        final List<Data> data = status.typeOffer == TypeOffer.buy
            ? <Data>[...status.myOfferBuyData.data, ...response.result!.data]
            : <Data>[...status.myOfferSaleData.data, ...response.result!.data];

        if (status.typeOffer == TypeOffer.buy) {
          status = status.copyWith(
            myOfferBuyData: isPagination
                ? ResultHome(
                    data: data,
                    totalItems: status.myOfferBuyData.totalItems,
                    totalPages: status.myOfferBuyData.totalPages,
                  )
                : response.result,
          );
        } else {
          status = status.copyWith(
            myOfferSaleData: isPagination
                ? ResultHome(
                    data: data,
                    totalItems: status.myOfferSaleData.totalItems,
                    totalPages: status.myOfferSaleData.totalPages,
                  )
                : response.result,
          );
        }
      } else {
        print('ERROR obteniendo la data de Home');
        // TODO: Mostrar alerta
      }
    } catch (err) {
      print('Get DataHome Error As: $err');
    }
  }

  void goDetailOperOffer(
    BuildContext context,
    String offerId,
    String isOper,
  ) {
    LdConnection.validateConnection().then((bool isConnectionValidvalue) {
      if (isConnectionValidvalue) {
        _route.goDetailOperOffer(
          context,
          offerId,
          isOper,
        );
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
  }

  int countFilters() {
    print(
        'extrafiltersstring ${status.extraFiltersString}  extrafilters ${status.extraFilters?.toJson()}');
    int count = 0;
    if (status.extraFilters?.range != null &&
        status.extraFilters?.range != -1) {
      count = count + 1;
    }
    if (status.extraFilters?.dateExpiry != null &&
        status.extraFilters?.dateExpiry != -1) {
      count = count + 1;
    }
    if (status.extraFilters?.status != null &&
        status.extraFilters?.status != -1) {
      count = count + 1;
    }
    if (status.extraFilters?.bank != null &&
        status.extraFilters?.bank != '[]') {
      count = count + 1;
      print(
          '${status.extraFilters!.bank} Filtro de bancos account ${status.extraFilters!.bank?.isEmpty}');
    }

    return count;
  }
}

enum SocialNetwork { facebook, instagram, twitter }
