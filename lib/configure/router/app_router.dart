import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

@immutable
class AppRouter {
  static FluroRouter router = FluroRouter.appRouter;

  final List<AppRoute> _routes;

  // TODO: Pending to implement 404 page
  // final Handler _notFoundHandler;

  List<AppRoute> get routes => _routes;

  const AppRouter({
    required List<AppRoute> routes,
    // required Handler notFoundHandler,
  }) : _routes = routes;

  // _notFoundHandler = notFoundHandler;

  void setupRoutes() {
    // router.notFoundHandler = _notFoundHandler;
    routes.forEach((AppRoute route) {
      router.define(route.route, handler: route.handler as Handler);
    });
  }
}
