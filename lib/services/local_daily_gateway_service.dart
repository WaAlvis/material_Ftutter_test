import 'package:dio/dio.dart';
import 'package:localdaily/services/models/home/body_home.dart';
import 'package:localdaily/services/models/register/body_register_data_user.dart';
import 'package:localdaily/services/models/register/result_register.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:retrofit/http.dart';

import 'models/home/reponse/result_home.dart';

part 'local_daily_gateway_service.g.dart';

class UrlsApi {
  static const String getDataHome = '/WebAdmin/Advertisement/GetData';
  static const String createUser = '/User/User';
}

@RestApi(baseUrl: 'http://3.135.189.138:4000')
abstract class LocalDailyGatewayService {
  //LOGIN

  factory LocalDailyGatewayService(Dio dio, {String baseUrl}) = _LocalDailyGatewayService;

  @POST(UrlsApi.getDataHome)
  Future<ResponseData<ResultHome>> getAdvertismentHome(
      @Body() BodyHome bodyHome,
      );

  @POST(UrlsApi.createUser)
  Future<ResponseData<ResultRegister>> registerUser(
      @Body() BodyRegisterDataUser bodyRegisterDataUser,
      );

  // @POST(UrlsApi.login)
  // Future<ResponseData<ResultLogin>> login(
  //     @Body() BodyLogin bodyLogin,
  //     );
}