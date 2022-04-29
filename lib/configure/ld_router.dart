import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:localdaily/commons/ld_enums.dart';
import 'package:localdaily/configure/router/app_router.dart';
import 'package:localdaily/configure/router/app_routes.dart';
import 'package:localdaily/pages/info/ui/info_view.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/data.dart';

import '../pages/history/ui/history_view.dart';

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
      AppRoutes.loginRoute.route,
      transition: TransitionType.none,
      // clearStack: true,
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

  void goDetailHistoryOperation(BuildContext context, Operation item) {
    AppRouter.router.navigateTo(
      context,
      AppRoutes.detailHistoryOperationRoute.route,
      transition: TransitionType.none,
      routeSettings: RouteSettings(
        arguments: <String, Operation>{'item': item},
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

  void goCreateOffer(BuildContext context, TypeOffer type) {
    AppRouter.router.navigateTo(
      context,
      type == TypeOffer.buy
          ? AppRoutes.createOfferBuyRoute.route
          : AppRoutes.createOfferSaleRoute.route,
      transition: TransitionType.none,
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

  void goEmailRegister(BuildContext context) {
    AppRouter.router.navigateTo(
      context,
      AppRoutes.registerEmailRoute.route,
      transition: TransitionType.none,
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
}
