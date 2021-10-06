import 'package:get_it/get_it.dart';
import 'package:localdaily/api/repository/interactor/api_interactor.dart';
import 'package:localdaily/configure/ld_router.dart';

GetIt locator = GetIt.instance;

Future<void> setUpLocator() async {

  locator.registerSingleton<LdRouter>(LdRouter());
  locator.registerSingleton<ApiInteractor>(ApiInteractor());
  // locator.registerSingleton<LoginService>(LoginService());
}