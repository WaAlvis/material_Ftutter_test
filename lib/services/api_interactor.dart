import 'package:localdaily/configure/get_it_locator.dart';
import 'package:localdaily/services/api_service.dart';
import 'package:localdaily/services/models/login/body_login.dart';
import 'package:localdaily/services/models/login/response_login.dart';
import 'package:localdaily/services/models/response_data.dart';

class ServiceInteractor {

  Future<ResponseData<ResponseLogin>> postLogin(BodyLogin bodyLogin) async {
    final  ResponseData<ResponseLogin> response =
      await locator<ApiService>().login(bodyLogin);

    return response;
  }
}