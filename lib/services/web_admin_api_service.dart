import 'package:dio/dio.dart';
import 'package:localdaily/services/models/login/body_login.dart';
import 'package:localdaily/services/models/login/response_login.dart';
import 'package:localdaily/services/models/registerDataUser/body_register_data_user.dart';
import 'package:localdaily/services/models/registerDataUser/response_register.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:retrofit/http.dart';

part 'web_admin_api_service.g.dart';

class UrlsApi {
  static const String registerUsers = '';
}

@RestApi(baseUrl: 'http://3.135.189.138:9001/User')
abstract class WebAdminApiService {

  factory WebAdminApiService(Dio dio, {String baseUrl}) = _WebAdminApiService;

 /* @GET(UrlsApi.users)
  Future<ResponseData> getUsers();*/

  @POST(UrlsApi.registerUsers)
  Future<ResponseData<ResponseRegister>> registerUser(
    @Body() BodyRegisterDataUser bodyRegisterDataUser,
  );
}