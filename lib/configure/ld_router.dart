import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:localdaily/configure/router/app_router.dart';
import 'package:localdaily/configure/router/app_routes.dart';

class LdRouter {
  static final LdRouter _singleton = LdRouter._internal();

  factory LdRouter() {
    return _singleton;
  }

  LdRouter._internal();

  /*final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void popT<T>(T result) {
    navigatorKey.currentState!.pop<T>(result);
  }

  void pop() {
    navigatorKey.currentState!.pop();
    // AppRouter.router.pop(context)
  }*/

  void goHome(BuildContext context) {
    /*return navigatorKey.currentState!
        .push(MaterialPageRoute<HomePage>(builder: (_) => const HomePage()));*/
    AppRouter.router.navigateTo(
       context,
       AppRoutes.homeRoute.route,
       replace: true,
       clearStack: true,
       transition: TransitionType.none,
    );
  }

  void goBuy(BuildContext context) {

    AppRouter.router.navigateTo(
      context,
      AppRoutes.buyRoute.route,
      replace: true,
      clearStack: true,
      transition: TransitionType.none,
    );
  }

  void goSell(BuildContext context) {

    AppRouter.router.navigateTo(
      context,
      AppRoutes.sellRoute.route,
      replace: true,
      clearStack: true,
      transition: TransitionType.none,
    );
  }
}
