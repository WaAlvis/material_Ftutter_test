import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:localdaily/pages/buy_sell/ui/buy_sell_view.dart';
import 'package:localdaily/pages/change_password/ui/change_password_view.dart';
import 'package:localdaily/pages/contact_support/ui/contact_support_view.dart';
import 'package:localdaily/pages/detail_history_operation/ui/detail_history_operation_view.dart';
import 'package:localdaily/pages/detail_offer/ui/detail_offer_view.dart';
import 'package:localdaily/pages/history/ui/history_view.dart';
import 'package:localdaily/pages/home/ui/home_view.dart';
import 'package:localdaily/pages/login/ui/login_view.dart';
import 'package:localdaily/pages/notification/ui/notification_view.dart';
import 'package:localdaily/pages/offer_buy/ui/offer_buy_view.dart';
import 'package:localdaily/pages/offer_sale/ui/offer_sale_view.dart';
import 'package:localdaily/pages/recover_psw/ui/recover_psw_view.dart';
import 'package:localdaily/pages/register/iu/register_view.dart';
import 'package:localdaily/pages/settings/ui/settings_view.dart';
import 'package:localdaily/pages/splash/ui/splash_view.dart';
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
              const SplashView(),
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

  static final AppRoute detailOfferRoute = AppRoute(
    '/detail_offer',
    Handler(
      handlerFunc: (BuildContext? context, __) => DetailOfferView(
        item: (context!.settings!.arguments! as Map<String, dynamic>)['item']
            as Data,
        isBuy: (context.settings!.arguments! as Map<String, dynamic>)['isbuy']
            as bool,
      ),
    ),
  );

  static final AppRoute detailHistoryOperationRoute = AppRoute(
    '/detail_history_operation',
    Handler(
      handlerFunc: (BuildContext? context, __) => DetailHistoryOperationView(
        item: (context!.settings!.arguments! as Map<String, Operation>)['item'],
      ),
    ),
  );

  static final AppRoute settingsRoute = AppRoute(
    '/settings',
    Handler(handlerFunc: (_, __) => const SettingsView()),
  );

  static final AppRoute changePswRoute = AppRoute(
    '/change_password',
    Handler(handlerFunc: (_, __) => const ChangePasswordView()),
  );

  static final AppRoute createOfferBuyRoute = AppRoute(
    '/create_offer_buy',
    Handler(handlerFunc: (_, __) => const OfferBuyView()),
  );

  static final AppRoute createOfferSaleRoute = AppRoute(
    '/create_offer_sale',
    Handler(handlerFunc: (_, __) => const OfferSaleView()),
  );

  static final AppRoute historyOperationsRoute = AppRoute(
    '/history_operations',
    Handler(handlerFunc: (_, __) => const HistoryView()),
  );

  static final AppRoute registerEmailRoute = AppRoute(
    '/register_email',
    Handler(handlerFunc: (_, __) => const RegisterView()),
  );

  static final AppRoute recoverPsw = AppRoute(
    '/recover_password',
    Handler(handlerFunc: (_, __) => const RecoverPswView()),
  );

  static final AppRoute notifications = AppRoute(
    '/notifications',
    Handler(handlerFunc: (_, __) => const NotificationView()),
  );

  static final AppRoute contactSupport = AppRoute(
    '/contact_support',
    Handler(
      handlerFunc: (_, __) => const ContactSupportView(
        advertisementId: '',
        reference: '',
        isbuy: true,
      ),
    ),
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
    detailOfferRoute,
    historyOperationsRoute,
    detailHistoryOperationRoute,
    settingsRoute,
    changePswRoute,
    recoverPsw,
    notifications,
    contactSupport,
    // registerValidateEmailRoute,
    // personalInfoRegisterRoute,
  ];
}
