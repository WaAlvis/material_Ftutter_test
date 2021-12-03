import 'package:dio/dio.dart';
import 'package:localdaily/services/models/create_offerts/getBanks/response/result_get_banks.dart';
import 'package:localdaily/services/models/create_offerts/offert/body_offert.dart';
import 'package:localdaily/services/models/create_offerts/offert/result_create_offert.dart';
import 'package:localdaily/services/models/home/body_home.dart';
import 'package:localdaily/services/models/home/get_offerts/reponse/result_home.dart';
import 'package:localdaily/services/models/login/body_login.dart';
import 'package:localdaily/services/models/login/result_login.dart';
import 'package:localdaily/services/models/pagination.dart';
import 'package:localdaily/services/models/register/body_register_data_user.dart';
import 'package:localdaily/services/models/register/result_register.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:retrofit/http.dart';

part 'local_daily_gateway_service.g.dart';

class UrlsApi {
  static const String getDataHome = '/WebAdmin/Advertisement/GetData';
  static const String createUser = '/User/User';
  static const String login = '/Identity/Authentication';
  static const String getBanks = '/Configuration/​ConfigurationBank​/GetData';
  static const String createOffert = '/WebAdmin/Advertisement';
}

///WebAdmin/Advertisement create offert sell buy

@RestApi(baseUrl: 'http://3.135.189.138:4000')
abstract class LocalDailyGatewayService {
  //LOGIN

  factory LocalDailyGatewayService(Dio dio, {String baseUrl}) =
      _LocalDailyGatewayService;

  @POST(UrlsApi.getDataHome)
  Future<ResponseData<ResultHome>> getAdvertismentHome(
    @Body() BodyHome bodyHome,
  );

  @POST(UrlsApi.createUser)
  Future<ResponseData<ResultRegister>> registerUser(
    @Body() BodyRegisterDataUser bodyRegisterDataUser,
  );

  @POST(UrlsApi.login)
  Future<ResponseData<ResultLogin>> loginUser(
    @Body() BodyLogin bodyLogin,
  );

  @POST(UrlsApi.getBanks)
  Future<ResponseData<ResultGetBanks>> getBanks(
    @Body() Pagination bodyGetBanks,
  );

  @POST(UrlsApi.createOffert)
  Future<ResponseData<ResultCreateOffert>> createOffert(
    @Body() BodyOffert bodyGetBanks,
  );

// @POST(UrlsApi.login)
// Future<ResponseData<ResultLogin>> login(
//     @Body() BodyLogin bodyLogin,
//     );
}

// { *loginUser
//    "identity": "w@w.com",
//   "password": "1234",
// "signature":"T2CswFciHcSgFxh8LKRYLuz2dqwuzSCWnat/KRxACqdJhr3aLJBWObPmVyUaE6xtpAca+F1r0F06M4eh2pv6IOUcQueMO7+IRq8Kym8Py48Exu13nOcMkJhoz+o5+alZz7wuHLaAE822PCdnMkEls651+DimZ9qe16SpYVyoisU+P16jUkWBNZ/YVP3xLSNn5yUUK9paYyrKkvviNhlUKcBK0ptu5BS8edadgTXs5PRvYOP7wNp/y8RGgXRfnvNEh6as2xjjvizhEIC0GLywT9MYt/VDCXHZDk+8mpN7wVv6qn6MHEzZw6Gw1q5ObxlGTn67Ap48GjHicLYb1w5fGw==",
// "wearableId": "d9b1289a-ae98-4e86-a145-ac046a8bd5be"
// }

// {* Create offert buy seller
//   "entity": {
//     "idTypeAdvertisement": "138412e9-4907-4d18-b432-70bdec7940c4",
//     "idCountry": "138412e9-4907-4d18-b432-70bdec7940c4",
//     "valueToSell": "5000",
//     "margin": "1",
//     "termsOfTrade": "solo pagos en la noche",
//     "idUserPublish": "ac8c8d30-391e-457a-8c1d-2f3a7d4e81d2"
//   },
//   "daysOfExpired": 7,
//   "strJsonAdvertisementBanks": "[{\"bankId\": \"249bfcd0-4ab0-49a8-a886-63ce42c919a6\",\"accountNumber\": \"555555555\",\"accountTypeId\": \"c047a07c-2daf-48a7-ad49-ec447a93485b\",\"documentNumber\": \"123456789\",\"titularUserName\": \"Roger Gutierrez\"},{\"bankId\": \"249bfcd0-4ab0-49a8-a886-63ce42c919a6\",\"accountNumber\":\"101010101\",\"accountTypeId\": \"c047a07c-2daf-48a7-ad49-ec447a93485b\",\"documentNumber\": \"987654321\",\"titularUserName\": \"Carmen Martinez\"}]"
// }

// { *Create User
// "nickName": "n",
// "firstName": "b",
// "secondName": "v",
// "firstLastName": "v",
// "secondLastName": "c",
// "dateBirth": "12/12/1221",
// "email": "test@g.com",
// "phone": "123",
// "userTypeId": "9c2f4526-5933-4404-96fc-784a87a7b674",
// "password": "1234",
// "isActive": true
// }

