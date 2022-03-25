import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:localdaily/app_theme.dart';
import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/configure/router/app_routes.dart';
import 'package:localdaily/providers/data_user_provider.dart';
import 'package:localdaily/utils/midaily_connect.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';

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
          ChangeNotifierProvider<DataUserProvider>(
            create: (_) => DataUserProvider(),
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
  StreamSubscription<dynamic>? _sub;

  @override
  void initState() {
    // DeepLink listener
    if (kIsWeb) return;
    _sub = uriLinkStream
        .listen((Uri? uri) => MiDailyConnect.handleIncomingLinks(context, uri));
    super.initState();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // navigatorKey: router.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Local Daily',
      theme: AppTheme.build(),
      onGenerateRoute: AppRouter.router.generator,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // supportedLocales: const [
      //   Locale('en'),
      //   Locale('es')
      // ],
      // home: SplashScreen(),
      // onGenerateRoute: locator<GfilesRoute>().initRoute
    );
  }
}
