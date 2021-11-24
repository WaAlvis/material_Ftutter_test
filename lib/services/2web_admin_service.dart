import 'package:dio/dio.dart';
import 'package:localdaily/services/models/home/body_home.dart';
import 'package:localdaily/services/models/home/reponse/result_home.dart';
import 'package:localdaily/services/models/register/body_register_data_user.dart';
import 'package:localdaily/services/models/register/result_register.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:retrofit/http.dart';

part 'web_admin_service.g.dart';

class UrlsApi {
  static const String users = '/User';
  static const String advertisement = '/Advertisement/GetData';
}

@RestApi(baseUrl: 'http://3.135.189.138:9001')
abstract class WebAdminService {
  factory WebAdminService(Dio dio, {String baseUrl}) = _WebAdminService;

  @POST(UrlsApi.users)
  Future<ResponseData<ResultRegister>> registerUser(
    @Body() BodyRegisterDataUser bodyRegisterDataUser,
  );

  @POST(UrlsApi.advertisement)
  Future<ResponseData<ResultHome>> getAdvertismentHome(
    @Body() BodyHome bodyHome,
  );
}
