import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:localdaily/configure/ld_router.dart';
import 'package:localdaily/services/api_interactor.dart';
import 'package:localdaily/services/local_daily_gateway_service.dart';

GetIt locator = GetIt.instance;

class LdLocator {
  static Future<void> setUpLocator() async {
    final Dio dio = _getDioApiService();

    locator.registerSingleton<LdRouter>(LdRouter());
    locator.registerSingleton<ServiceInteractor>(ServiceInteractor());
    locator.registerSingleton<LocalDailyGatewayService>(
      LocalDailyGatewayService(dio),
    );
    /* locator.registerSingleton<LocalDailyGatewayService>(
      LocalDailyGatewayService(dio),
    ); */
  }

  static Dio _getDioApiService() {
    final Dio dio = Dio();

    dio.options.receiveDataWhenStatusError = true;

    dio.options.connectTimeout = 30 * 1000;
    dio.options.receiveTimeout = 30 * 1000;

    /*dio.options.headers[HttpHeaders.userAgentHeader] =
    await _device.userAgent();

    // dio.options.headers['Demo-Header'] = 'demo header';
    dio.options.headers['app-version'] = await _device.appVersion();*/

    dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestBody: true,
      ),
    );

    return dio;
  }
}
