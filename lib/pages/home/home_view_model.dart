import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home_status.dart';

class HomeViewModel extends EffectsViewModel<HomeStatus, HomeEffect> {
  final LdRouter _route;
  final ServiceInteractor _interactor;
  final int itemsPerPage = 3;
  late LocalStorageService _localStorage;

  HomeViewModel(this._route, this._interactor, this._localStorage) {
    status = HomeStatus(
      hideWallet: false,
      hideValues: false,
      isError: false,
      countNotification: 0,
      offersBuyDataHome: ResultHome(
        data: <Data>[],
        totalItems: itemsPerPage,
        totalPages: 1,
      ),
      offersSaleDataHome: ResultHome(
        data: <Data>[],
        totalItems: itemsPerPage,
        totalPages: 1,
      ),
      operationBuyData: ResultHome(
        data: <Data>[],
        totalItems: itemsPerPage,
        totalPages: 1,
      ),
      operationSaleData: ResultHome(
        data: <Data>[],
        totalItems: itemsPerPage,
        totalPages: 1,
      ),
      myOfferBuyData: ResultHome(
        data: <Data>[],
        totalItems: itemsPerPage,
        totalPages: 1,
      ),
      myOfferSaleData: ResultHome(
        data: <Data>[],
        totalItems: itemsPerPage,
        totalPages: 1,
      ),
      optionTab: OptionTab.home,
      typeOffer: TypeOffer.buy,
      image: LdAssets.buyNoOffer,
      titleText: 'Aún no tienes ofertas de compra',
      buttonText: 'Crear oferta de compra',
      balance: -1,
      filtersArguments: FiltersArguments(),
    );
  }

  Future<void> onItemTapped(
    OptionTab optionTab,
    String address,
  ) async {
    status = status.copyWith(optionTab: optionTab);
    // status = status.copyWith(
    //     extraFilters: ExtraFilters(
    //         range: null, dateExpiry: null, bank: null, status: null));
    if (optionTab == OptionTab.myOffers) {
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
      getCountNotification(userProvider.getDataUserLogged!.id, context);
    }
    FiltersArguments filtersArguments = FiltersArguments(
        // extraFilters: status.extraFilters,
        homeStatus: status,
        indexTab: status.optionTab.index,
        setFilters: (ExtraFilters extraFilters, String extraFiltersString) {
          extraFilters.status = extraFilters.status ?? -2;
          extraFiltersString =
              extraFiltersString.replaceAll('status: null', 'status: -2');
          extraFiltersString = extraFiltersString.replaceAll('null', '');
          extraFiltersString = extraFiltersString.replaceAll('[]', '');
          status = status.copyWith(extraFilters: extraFilters);
          status = status.copyWith(extraFiltersString: extraFiltersString);
          print('### setfilters ${status.extraFiltersString}');

          getData(resultDataUser?.id ?? '', refresh: true);
        },
        getFilters: <int>() => status.optionTab.index,
        clearFilters: () {
          status = status.copyWith(
              extraFilters: ExtraFilters(), extraFiltersString: '');
        });
    status = status.copyWith(filtersArguments: filtersArguments);
    getData(
      resultDataUser?.id ?? '',
    );
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
      typeOffer: type,
      extraFiltersString: '',
      extraFilters: ExtraFilters(),
      thereIsMoreData: true,
    );

    await getData(
      userId,
      refresh: true,
    );
  }

  Future<void> launchWeb(SocialNetwork type) async {
    const String instagramUrl =
        'https://instagram.com/local.daily_?igshid=YmMyMTA2M2Y=';
    const String twitterUrl =
        'https://twitter.com/localdaily_?s=21&t=djl82p5fSxCknxZ8qIoiWA';
    const String facebookUrl =
        'https://www.facebook.com/profile.php?id=100081114404165';
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

  void launchWebConnect(SocialNetwork type) {
    LdConnection.validateConnection().then((bool isConnectionValid) async {
      if (isConnectionValid) {
        launchWeb(type);
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
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

  void goSettingsUpdate(BuildContext context) {
    LdConnection.validateConnection().then((bool isConnectionValid) {
      if (isConnectionValid) {
        _route.goSettingsUpdate(context);
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
      } else {
        addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
      }
    });
  }

  void goSupportCases(BuildContext context) {
    LdConnection.validateConnection().then((bool isConnectionValidvalue) {
      if (isConnectionValidvalue) {
        _route.goSupportCases(context);
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

  Future<void> getCountNotification(String userId, BuildContext context) async {
    try {
      final DataUserProvider dataUserProvider =
          context.read<DataUserProvider>();

      final token = dataUserProvider.getTokenLogin;
      final BodyNotificationCounter body =
          BodyNotificationCounter(idUser: userId);
      _interactor
          .getNotificationsUnread(body, 'Bearer ${token!.token}')
          .then((response) {
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

  String getFinishDate(int timeStamp) {
    final DateTime dateFinish = DateTime.fromMillisecondsSinceEpoch(
      timeStamp,
    );
    final DateTime now = DateTime.now();
    final Duration difference = dateFinish.difference(now);
    return difference.inMinutes < 59
        ? '${difference.inMinutes} m'
        : difference.inHours < 23
            ? '${difference.inHours} h'
            : '${difference.inDays} d';
  }

  Future<void> getData(
    String userId, {
    bool refresh = false,
    bool isPagination = false,
  }) async {
    final bool next = await LdConnection.validateConnection();
    if (next) {
      if (status.optionTab == OptionTab.home) {
        await getDataHome(
          userId,
          refresh: refresh,
          isPagination: isPagination,
        );
      } else if (status.optionTab == OptionTab.operations) {
        if (userId.isNotEmpty)
          await getDataOperations(
            userId,
            refresh: refresh,
            isPagination: isPagination,
          );
      } else if (status.optionTab == OptionTab.myOffers) {
        if (userId.isNotEmpty)
          await getDataOffers(
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
  // Future<void> getData(
  //   String userId,
  //     {bool refresh = false,
  //       bool isPagination = false,
  //     })
  //   async {
  //   final bool next = await LdConnection.validateConnection();
  //   if (next) {
  //     if (status.optionTab == OptionTab.home) {
  //       await getDataHome(
  //         userId,
  //         refresh: refresh,
  //         isPagination: isPagination,
  //       );
  //     }
  //     else if (status.optionTab == OptionTab.operations) {
  //       if (userId.isNotEmpty) {
  //         await getDataOperations(
  //           userId,
  //           refresh: refresh,
  //           isPagination: isPagination,
  //         );
  //       }
  //     }
  //     else if (status.optionTab == OptionTab.myOffers) {
  //       if (userId.isNotEmpty){
  //         await getDataOffers(
  //           userId,
  //           refresh: refresh,
  //           isPagination: isPagination,
  //         );
  //       }
  //     }
  //   }
  //     else {
  //     addEffect(ShowSnackbarConnectivityEffect('Sin conexión a internet'));
  //     status = status.copyWith(isLoading: false);
  //   }
  // }

  // ------ CONSULTA PARA TRAER TARJETAS DEL INICIO ------
  Future<void> getDataHome(
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
      strJsonExtraFilters:
          status.extraFiltersString?.replaceAll('-1', '') ?? '',
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
          if (status.offersSaleDataHome.totalItems == data.length) {
            status = status.copyWith(thereIsMoreData: false);
          }
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
          if (status.offersBuyDataHome.totalItems == data.length) {
            status = status.copyWith(thereIsMoreData: false);
          }
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
        statusCode: '',
        idUserExclusion: '',
        idUserInteraction: userId,
        strJsonExtraFilters:
            status.extraFiltersString != null && status.extraFiltersString != ''
                ? status.extraFiltersString!.replaceAll('-1', '')
                : '');
    final BodyHome body = BodyHome(
      pagination: pagination,
      filters: filters,
    );

    try {
      print('${status.extraFiltersString} extra  ${filters.toJson()}');

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
          if (status.operationSaleData.totalItems == data.length) {
            status = status.copyWith(thereIsMoreData: false);
          }
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
          if (status.operationBuyData.totalItems == data.length) {
            status = status.copyWith(thereIsMoreData: false);
          }
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
        strJsonExtraFilters:
            status.extraFiltersString?.replaceAll('-1', '') ?? 'status:-2');
    final BodyHome body = BodyHome(
      pagination: pagination,
      filters: filters,
    );
    // Solicitud al servicio
    try {
      // print('@@@ ${status.extraFiltersString}');
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
          if (status.myOfferBuyData.totalItems == data.length) {
            status = status.copyWith(thereIsMoreData: false);
          }
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
          if (status.myOfferSaleData.totalItems == data.length) {
            status = status.copyWith(thereIsMoreData: false);
          }
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
        status.extraFilters?.status != -2) {
      count = count + 1;
    }
    if (status.extraFilters?.bank != null &&
        status.extraFilters?.bank != '[]') {
      count = count + 1;
    }

    return count;
  }
}
