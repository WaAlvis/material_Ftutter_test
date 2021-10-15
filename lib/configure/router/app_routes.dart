import 'package:fluro/fluro.dart';
import 'package:localdaily/pages/buy/ui/buy_sell_view.dart';
import 'package:localdaily/pages/home/ui/home_view.dart';

class AppRoutes {

  /*static final loginRoute = AppRoute(
    '/login',
    Handler(handlerFunc: (_, __) => LoginPhoneSavedView()),
  );*/

  /*static final registerRoute = AppRoute(
    '/register',
    Handler(handlerFunc: (_, __) => SignupPage()),
  );*/

  static final rootRoute = AppRoute(
    '/',
    Handler(handlerFunc: (context, parameters) => const HomeView()),
  );

  static final homeRoute = AppRoute(
    '/home',
    Handler(handlerFunc: (_, __) => const HomeView()),
  );

  static final buyRoute = AppRoute(
    '/buy',
    Handler(handlerFunc: (_, __) => const BuySellView()),
  );

  static final sellRoute = AppRoute(
    '/sell',
    Handler(handlerFunc: (_, __) => const BuySellView()),
  );

  static final List<AppRoute> routes = [
    rootRoute,
    homeRoute,
    buyRoute,
    sellRoute
  ];
}
