import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:localdaily/configure/router/app_router.dart';
import 'package:localdaily/configure/router/app_routes.dart';
import 'package:localdaily/pages/home/ui/home_view.dart';

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

  void goCreateOffert(BuildContext context, TypeOffert type) {
    AppRouter.router.navigateTo(
      context,
      type == TypeOffert.buy
          ? AppRoutes.createOffertBuyRoute.route
          : AppRoutes.createOffertSaleRoute.route,
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

  void goValidateEmail(BuildContext context) {
    AppRouter.router.navigateTo(
      context,
      AppRoutes.registerValidateEmailRoute.route,
      transition: TransitionType.none,
    );
  }

  void goPersonalInfoRegister(BuildContext context) {
    AppRouter.router.navigateTo(
      context,
      AppRoutes.personalInfoRegisterRoute.route,
      transition: TransitionType.none,
    );
  }
}
