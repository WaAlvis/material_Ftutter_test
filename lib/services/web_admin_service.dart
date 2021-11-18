import 'package:dio/dio.dart';
import 'package:localdaily/services/models/register/body_register_data_user.dart';
import 'package:localdaily/services/models/register/result_register.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:retrofit/http.dart';

part 'web_admin_service.g.dart';

class UrlsApi {
  static const String registerUsers = '';
}

@RestApi(baseUrl: 'http://3.135.189.138:9001/User')
abstract class WebAdminService {

  factory WebAdminService(Dio dio, {String baseUrl}) = _WebAdminService;

 /* @GET(UrlsApi.users)
  Future<ResponseData> getUsers();*/

  @POST(UrlsApi.registerUsers)
  Future<ResponseData<ResultRegister>> registerUser(
    @Body() BodyRegisterDataUser bodyRegisterDataUser,
  );
}