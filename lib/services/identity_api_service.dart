import 'package:dio/dio.dart';
import 'package:localdaily/services/models/login/body_login.dart';
import 'package:localdaily/services/models/login/response_login.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:retrofit/http.dart';

part 'identity_api_service.g.dart';

class UrlsApi {
  static const String users = '/Authentication';
}

@RestApi(baseUrl: 'http://18.117.71.211:9000/Identity')
abstract class IdentityApiService {

  factory IdentityApiService(Dio dio, {String baseUrl}) = _IdentityApiService;

 /* @GET(UrlsApi.users)
  Future<ResponseData> getUsers();*/

  @POST(UrlsApi.users)
  Future<ResponseData<ResponseLogin>> login(
    @Body() BodyLogin bodyLogin,
  );


}