import 'package:bogota_app/data/repository/repository.dart';

import 'package:bogota_app/data/service/filter_service.dart';

import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/data/service/splash_service.dart';
import 'package:bogota_app/data/service/unmissable_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setUpLocator() async {

  locator.registerSingleton<IdtRoute>(IdtRoute());
  locator.registerSingleton<ApiInteractor>(ApiInteractor());

  locator.registerSingleton<SplashRepository>(SplashRepository());
  locator.registerSingleton<PlaceRepository>(PlaceRepository());
  locator.registerSingleton<FilterService>(FilterService());
  locator.registerSingleton<SplashService>(SplashService());

  locator.registerSingleton<UnmissableService>(UnmissableService());

  /* locator.registerSingletonAsync(() async {
    final database = Database();
    await database.initDb();
    return database;
  }); */

}
