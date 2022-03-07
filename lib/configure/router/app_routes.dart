import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:localdaily/pages/buy_sell/ui/buy_sell_view.dart';
import 'package:localdaily/pages/detail_offer_buy/ui/detail_offer_buy_view.dart';
import 'package:localdaily/pages/home/ui/home_view.dart';
import 'package:localdaily/pages/login/ui/login_view.dart';
import 'package:localdaily/pages/offer_buy/ui/offer_buy_view.dart';
import 'package:localdaily/pages/offer_sale/ui/offer_sale_view.dart';
import 'package:localdaily/pages/register/iu/register_view.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/data.dart';
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

  static final AppRoute detailOffer = AppRoute(
    '/detail_offer',
    Handler(handlerFunc: (BuildContext? context, __) =>
    DetailOfferBuyView(
      item: (context!.settings!.arguments! as Map<String, Data>)['item'],
    ),),
  );

  static final AppRoute createOfferBuyRoute = AppRoute(
    '/create_offer_buy',
    Handler(handlerFunc: (_, __) => const OfferBuyView()),
  );

  static final AppRoute createOfferSaleRoute = AppRoute(
    '/create_offer_sale',
    Handler(handlerFunc: (_, __) => const OfferSaleView()),
  );

  static final AppRoute registerEmailRoute = AppRoute(
    '/register_email',
    Handler(handlerFunc: (_, __) => const RegisterView()),
  );

  // static final AppRoute registerValidateEmailRoute = AppRoute(
  //   '/register_validate_email',
  //   Handler(handlerFunc: (_, __) => const ValidateEmailView()),
  // );
  // static final AppRoute personalInfoRegisterRoute = AppRoute(
  //   '/personal_info_register',
  //   Handler(handlerFunc: (_, __) => const PersonalInfoRegisterView()),
  // );

  static final List<AppRoute> routes = <AppRoute>[
    rootRoute,
    homeRoute,
    buyRoute,
    sellRoute,
    loginRoute,
    createOfferSaleRoute,
    createOfferBuyRoute,
    registerEmailRoute,
    detailOffer,
    // registerValidateEmailRoute,
    // personalInfoRegisterRoute,
  ];
}
