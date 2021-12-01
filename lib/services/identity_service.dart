import 'package:dio/dio.dart';
import 'package:localdaily/services/models/login/body_login.dart';
import 'package:localdaily/services/models/login/result_login.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:retrofit/http.dart';

part 'identity_service.g.dart';

class UrlsApi {
  static const String login = '/Authentication';
}

@RestApi(baseUrl: 'http://18.117.71.211:9000/Identity')
abstract class IdentityService {//LOGIN

  factory IdentityService(Dio dio, {String baseUrl}) = _IdentityService;

  @POST(UrlsApi.login)
  Future<ResponseData<ResultLogin>> login(
    @Body() BodyLogin bodyLogin,
  );
}
