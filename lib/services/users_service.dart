import 'package:dio/dio.dart';
import 'package:localdaily/services/models/register/body_register_data_user.dart';
import 'package:localdaily/services/models/register/result_register.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:retrofit/http.dart';

part 'users_service.g.dart';

class UrlsApi {
  static const String createUser = '/User';
}

@RestApi(baseUrl: 'http://3.135.189.138:9002')
abstract class UsersService {

  factory UsersService(Dio dio, {String baseUrl}) = _UsersService;

  @POST(UrlsApi.createUser)
  Future<ResponseData<ResultRegister>> registerUser(
      @Body() BodyRegisterDataUser bodyRegisterDataUser,
      );
}
