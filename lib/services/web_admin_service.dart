import 'package:dio/dio.dart';
import 'package:localdaily/services/models/home/body_home.dart';
import 'package:localdaily/services/models/home/reponse/result_home.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:retrofit/http.dart';

part 'web_admin_service.g.dart';

class UrlsApi {
  static const String getDataHome = '/GetData';
}

@RestApi(baseUrl: 'http://3.135.189.138:9001/Advertisement')
abstract class WebAdminService {

  factory WebAdminService(Dio dio, {String baseUrl}) = _WebAdminService;

  @POST(UrlsApi.getDataHome)
  Future<ResponseData<ResultHome>> getAdvertismentHome(
    @Body() BodyHome bodyHome,
  );


}
