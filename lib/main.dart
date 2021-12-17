import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/configure/router/app_routes.dart';
import 'package:localdaily/providers/user_provider.dart';
import 'package:provider/provider.dart';

import 'configure/router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppRouter(routes: AppRoutes.routes).setupRoutes();

  LdLocator.setUpLocator();
  await locator.allReady();

  runZonedGuarded(() {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
            create: (_) => UserProvider(),
          ),
        ],
        child: MyApp(),
      ),
    );
  }, (Object error, StackTrace stackTrace) {
    // TODO: Agregar control de errores
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final LdRouter router = GetIt.instance.get<LdRouter>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // navigatorKey: router.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Local Daily',
      theme: AppTheme.build(),
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      onGenerateRoute: AppRouter.router.generator,
      // home: SplashScreen(),
      // onGenerateRoute: locator<GfilesRoute>().initRoute
    );
  }
}
