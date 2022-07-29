import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:localdaily/commons/ld_enums.dart';
import 'package:localdaily/configure/router/app_router.dart';
import 'package:localdaily/configure/router/app_routes.dart';
import 'package:localdaily/pages/filters/ui/filters_view.dart';
import 'package:localdaily/pages/info/ui/info_view.dart';
import 'package:localdaily/services/models/contact_support/body_contact_support.dart';
import 'package:localdaily/services/models/history_operations_user/response/data_user_advertisement.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/data.dart';

class LdRouter {
  static final LdRouter _singleton = LdRouter._internal();

  factory LdRouter() {
    return _singleton;
  }

  LdRouter._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void popT<T>(T result) {
    navigatorKey.currentState!.pop<T>(result);
  }

  void pop(BuildContext context) {
    // navigatorKey.currentState!.pop();
    AppRouter.router.pop(context);
  }

  void popTwo(BuildContext context) {
    navigatorKey.currentState!.pop();
    AppRouter.router.pop(context);
  }

  void goHome(BuildContext context) {
    AppRouter.router.navigateTo(
      context,
      AppRoutes.homeRoute.route,
      replace: true,
      clearStack: true,
      transition: TransitionType.none,
    );
  }

  void goLoginForLogout(BuildContext context) {
    AppRouter.router.navigateTo(
      context,
      AppRoutes.homeRoute.route,
      transition: TransitionType.none,
      clearStack: true,
      replace: true,
    );
  }

  void goBuy(BuildContext context) {
    AppRouter.router.navigateTo(
      context,
      AppRoutes.buyRoute.route,
      transition: TransitionType.none,
    );
  }

  void goSell(BuildContext context) {
    AppRouter.router.navigateTo(
      context,
      AppRoutes.sellRoute.route,
      transition: TransitionType.none,
    );
  }

  void goLogin(BuildContext context) {
    AppRouter.router.navigateTo(
      context,
      AppRoutes.loginRoute.route,
      transition: TransitionType.none,
    );
  }

  void goDetailOffer(BuildContext context, Data item, {bool isBuy = false}) {
    AppRouter.router.navigateTo(
      context,
      AppRoutes.detailOfferRoute.route,
      transition: TransitionType.none,
      routeSettings: RouteSettings(
        arguments: <String, dynamic>{'item': item, 'isbuy': isBuy},
      ),
    );
  }

  void goHistoryOperations(
    BuildContext context,
  ) {
    AppRouter.router.navigateTo(
      context,
      AppRoutes.historyOperationsRoute.route,
      transition: TransitionType.none,
    );
  }

  void goDetailHistoryOperation(
      BuildContext context, DataUserAdvertisement item,
      {required bool isBuying}) {
    AppRouter.router.navigateTo(
      context,
      AppRoutes.detailHistoryOperationRoute.route,
      transition: TransitionType.none,
      routeSettings: RouteSettings(
        arguments: <String, dynamic>{
          'item': item,
          'isBuying': isBuying,
        },
      ),
    );
  }

  void goProfileSeller(
    BuildContext context,
    String idUser,
    String nickName,
  ) {
    AppRouter.router.navigateTo(
      context,
      AppRoutes.profileSellerRoute.route,
      transition: TransitionType.none,
      routeSettings: RouteSettings(
        arguments: <String, String>{'idUser': idUser, 'nickName': nickName},
      ),
    );
  }

  void goSettings(
    BuildContext context,
  ) {
    AppRouter.router.navigateTo(
      context,
      AppRoutes.settingsRoute.route,
      transition: TransitionType.none,
    );
  }

  void goChangePsw(
    BuildContext context,
  ) {
    AppRouter.router.navigateTo(
      context,
      AppRoutes.changePswRoute.route,
      transition: TransitionType.none,
    );
  }

  void goDeleteAccount(
      BuildContext context,
      ) {
    AppRouter.router.navigateTo(
      context,
      AppRoutes.deleteAccount.route,
      transition: TransitionType.none,
    );
  }


  void goSettingsUpdate(
    BuildContext context,
  ) {
    AppRouter.router.navigateTo(
      context,
      AppRoutes.settingsUpdateRoute.route,
      transition: TransitionType.none,
    );
  }

  // void goSettingsPostChangePsw(
  //   BuildContext context,
  // ) {
  //   AppRouter.router.navigateTo(
  //     context,
  //     AppRoutes.settingsRoute.route,
  //     transition: TransitionType.none,
  //   );
  // }

  void goCreateOffer(BuildContext context, TypeOffer type) {
    AppRouter.router.navigateTo(
      context,
      type == TypeOffer.buy
          ? AppRoutes.createOfferBuyRoute.route
          : AppRoutes.createOfferSaleRoute.route,
      transition: TransitionType.none,
    );
  }

  void goEmailRegister(BuildContext context) {
    AppRouter.router.navigateTo(
      context,
      AppRoutes.registerEmailRoute.route,
      transition: TransitionType.none,
    );
  }

  void goRecoverPsw(BuildContext context) {
    AppRouter.router.navigateTo(
      context,
      AppRoutes.recoverPsw.route,
      transition: TransitionType.none,
    );
  }

  void goNotifications(BuildContext context) {
    AppRouter.router.navigateTo(
      context,
      AppRoutes.notifications.route,
      transition: TransitionType.none,
    );
  }

  void goContactSupport(
    BuildContext context,
    String offerId,
    int reference, {
    bool isBuy = false,
    bool isDisputa = false,
  }) {
    AppRouter.router.navigateTo(
      context,
      AppRoutes.contactSupport.route,
      transition: TransitionType.none,
      routeSettings: RouteSettings(
        arguments: <String, dynamic>{
          'id': offerId,
          'reference': reference,
          'isBuy': isBuy,
          'isDisputa': isDisputa,
        },
      ),
    );
  }

  void goDetailSupport(
    BuildContext context,
    BodyContactSupport advertisement,
  ) {
    AppRouter.router.navigateTo(
      context,
      AppRoutes.detailSupport.route,
      transition: TransitionType.none,
      routeSettings: RouteSettings(
        arguments: <String, dynamic>{
          'advertisement': advertisement,
        },
      ),
    );
  }

  void goFilters(
    BuildContext context,
    FiltersArguments filtersArguments,
  ) {
    AppRouter.router.navigateTo(
      context,
      AppRoutes.filters.route,
      transition: TransitionType.none,
      routeSettings: RouteSettings(
        arguments: <String, FiltersArguments>{'extraFilters': filtersArguments},
      ),
    );
  }

  void goInfoView(BuildContext context, InfoViewArguments arguments) {
    AppRouter.router.navigateTo(
      context,
      AppRoutes.info.route,
      transition: TransitionType.none,
      routeSettings: RouteSettings(
        arguments: <String, InfoViewArguments>{'arguments': arguments},
      ),
    );
  }

// void goValidateEmail(BuildContext context) {
//   AppRouter.router.navigateTo(
//     context,
//     AppRoutes.registerValidateEmailRoute.route,
//     transition: TransitionType.none,
//   );
// }
//
// void goPersonalInfoRegister(BuildContext context) {
//   AppRouter.router.navigateTo(
//     context,
//     AppRoutes.personalInfoRegisterRoute.route,
//     transition: TransitionType.none,
//   );
// }

  void goDetailOperOffer(
    BuildContext context,
    String offerId,
    String isOper, {
    bool replace = false,
  }) {
    AppRouter.router.navigateTo(
      context,
      AppRoutes.detailOperOfferRoute.route,
      replace: replace,
      transition: TransitionType.none,
      routeSettings: RouteSettings(
        arguments: <String, String>{
          'offerId': offerId,
          'type': isOper,
        },
      ),
    );
  }

  void goAttachedFile(
    BuildContext context,
    String isOper,
    String offerIdFile,
    String extensionFile,
    String isView,
  ) {
    AppRouter.router.navigateTo(
      context,
      AppRoutes.attachedFileRoute.route,
      transition: TransitionType.none,
      routeSettings: RouteSettings(
        arguments: <String, String>{
          'type': isOper,
          'offerId': offerIdFile,
          'extensionFile': extensionFile,
          'isView': isView,
        },
      ),
    );
  }

  void goSupportCases(
    BuildContext context,
  ) {
    AppRouter.router.navigateTo(
      context,
      AppRoutes.supportCasesRoute.route,
      transition: TransitionType.none,
    );
  }
}
