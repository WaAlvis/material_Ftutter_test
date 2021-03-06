import 'package:bogota_app/data/repository/interactor.dart';

import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/data/repository/service/audioguide_service.dart';
import 'package:bogota_app/data/repository/service/bestRated_service.dart';
import 'package:bogota_app/data/repository/service/close_to_me_service.dart';
import 'package:bogota_app/data/repository/service/event_service.dart';
import 'package:bogota_app/data/repository/service/favorite_service.dart';
import 'package:bogota_app/data/repository/service/filter_service.dart';
import 'package:bogota_app/data/repository/service/eat_service.dart';
import 'package:bogota_app/data/repository/service/gps_service.dart';
import 'package:bogota_app/data/repository/service/language_avalible_service.dart';
import 'package:bogota_app/data/repository/service/menu_images_service.dart';
import 'package:bogota_app/data/repository/service/data_user_service.dart';
import 'package:bogota_app/data/repository/service/reset_password.dart';
import 'package:bogota_app/data/repository/service/search_service.dart';
import 'package:bogota_app/data/repository/service/savedPlaces_service.dart';
import 'package:bogota_app/data/repository/service/sleep_service.dart';
import 'package:bogota_app/data/repository/service/splash_service.dart';
import 'package:bogota_app/data/repository/service/unmissable_service.dart';
import 'package:bogota_app/data/repository/service/zone_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setUpLocator() async {
  locator.registerSingleton<IdtRoute>(IdtRoute());
  locator.registerSingleton<ApiInteractor>(ApiInteractor());
  locator.registerSingleton<FilterService>(FilterService());
  locator.registerSingleton<GpsService>(GpsService());
  locator.registerSingleton<SplashService>(SplashService());
  locator.registerSingleton<MenuImagesService>(MenuImagesService());

  locator.registerSingleton<UnmissableService>(UnmissableService());
  locator.registerSingleton<LanguageAvalibleService>(LanguageAvalibleService());
  locator.registerSingleton<CloseToMeService>(CloseToMeService());
  locator.registerSingleton<EatService>(EatService());
  locator.registerSingleton<AudioGuideService>(AudioGuideService());
  locator.registerSingleton<EventService>(EventService());
  locator.registerSingleton<SleepService>(SleepService());
  locator.registerSingleton<DataUserService>(DataUserService());
  locator.registerSingleton<ResetPasswordService>(ResetPasswordService());
  locator.registerSingleton<BestRatedService>(BestRatedService());
  locator.registerSingleton<SavedPlacesService>(SavedPlacesService());
  locator.registerSingleton<ZonesService>(ZonesService());
  locator.registerSingleton<SearchService>(SearchService());
  locator.registerSingleton<FavoriteService>(FavoriteService());

  /* locator.registerSingletonAsync(() async {
    final database = Database();
    await database.initDb();
    return database;
  }); */
}
