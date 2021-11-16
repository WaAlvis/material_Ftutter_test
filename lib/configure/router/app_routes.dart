import 'package:fluro/fluro.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:localdaily/pages/buy_sell/ui/buy_sell_view.dart';
import 'package:localdaily/pages/home/ui/home_view.dart';
import 'package:localdaily/pages/login/ui/login_view.dart';
import 'package:localdaily/pages/personal_info_register/ui/personal_info_register_view.dart';
import 'package:localdaily/pages/register/pages/1emailForRegister/ui/register_email_view.dart';
import 'package:localdaily/pages/register/pages/2validate_email/ui/validate_email_view.dart';

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
      Handler(handlerFunc: (BuildContext? context, parameters) => const HomeView(),)
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
    registerEmailRoute,
    registerValidateEmailRoute,
    personalInfoRegisterRoute,
  ];
}
