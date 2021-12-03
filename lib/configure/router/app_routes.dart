import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:localdaily/pages/buy_sell/ui/buy_sell_view.dart';
import 'package:localdaily/pages/home/ui/home_view.dart';
import 'package:localdaily/pages/login/ui/login_view.dart';
import 'package:localdaily/pages/offert_sale/ui/offert_sale_view.dart';
import 'package:localdaily/pages/register/iu/1emailForRegister/register_email_view.dart';
import 'package:localdaily/pages/register/iu/2validate_email/validate_email_view.dart';
import 'package:localdaily/pages/register/iu/3personal_info_register/personal_info_register_view.dart';

class AppRoutes {
  /*static final loginRoute = AppRoute(
    '/login',
    Handler(handlerFunc: (_, __) => LoginPhoneSavedView()),
  );*/

  /*static final registerRoute = AppRoute(
    '/register',
    Handler(handlerFunc: (_, __) => SignupPage()),
  );*/

  static final AppRoute rootRoute = AppRoute(
    '/',
    // Handler(handlerFunc: (BuildContext? context, parameters) => const LoginView(),)
    Handler(
      handlerFunc:
          (BuildContext? context, Map<String, List<String>> parameters) =>
              const HomeView(),
    ),
  );

  static final AppRoute homeRoute = AppRoute(
    '/home',
    Handler(handlerFunc: (_, __) => const HomeView()),
  );

  static final AppRoute buyRoute = AppRoute(
    '/buy',
    Handler(handlerFunc: (_, __) => const BuySellView(isBuy: true)),
  );

  static final AppRoute sellRoute = AppRoute(
    '/sell',
    Handler(handlerFunc: (_, __) => const BuySellView()),
  );

  static final AppRoute loginRoute = AppRoute(
    '/login',
    Handler(handlerFunc: (_, __) => const LoginView()),
  );
  static final AppRoute createOffertSaleRoute = AppRoute(
    '/create_offert_sale',
    Handler(handlerFunc: (_, __) => const OffertSaleView()),
  );

  static final AppRoute registerEmailRoute = AppRoute(
    '/register_email',
    Handler(handlerFunc: (_, __) => const RegisterEmailView()),
  );

  static final AppRoute registerValidateEmailRoute = AppRoute(
    '/register_validate_email',
    Handler(handlerFunc: (_, __) => const ValidateEmailView()),
  );
  static final AppRoute personalInfoRegisterRoute = AppRoute(
    '/personal_info_register',
    Handler(handlerFunc: (_, __) => const PersonalInfoRegisterView()),
  );

  static final List<AppRoute> routes = <AppRoute>[
    rootRoute,
    homeRoute,
    buyRoute,
    sellRoute,
    loginRoute,
    createOffertSaleRoute,
    registerEmailRoute,
    registerValidateEmailRoute,
    personalInfoRegisterRoute,
  ];
}
