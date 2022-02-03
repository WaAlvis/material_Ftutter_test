import 'package:dio/dio.dart';
import 'package:localdaily/services/models/create_offers/get_banks/response/result_get_banks.dart';
import 'package:localdaily/services/models/create_offers/get_doc_type/response/result_get_docs_type.dart';
import 'package:localdaily/services/models/create_offers/offer/body_offer.dart';
import 'package:localdaily/services/models/create_offers/offer/result_create_offer.dart';
import 'package:localdaily/services/models/detail_offer/body_create_smart_contract.dart';
import 'package:localdaily/services/models/detail_offer/result_create_smart_contract.dart';
import 'package:localdaily/services/models/home/body_home.dart';
import 'package:localdaily/services/models/home/get_offers/reponse/result_home.dart';
import 'package:localdaily/services/models/login/body_login.dart';
import 'package:localdaily/services/models/login/get_by_id/result_data_user.dart';
import 'package:localdaily/services/models/login/result_login.dart';
import 'package:localdaily/services/models/pagination.dart';
import 'package:localdaily/services/models/register/body_register_data_user.dart';
import 'package:localdaily/services/models/register/result_register.dart';
import 'package:localdaily/services/models/register/send_validate/body_pin_email.dart';
import 'package:localdaily/services/models/register/send_validate/result_pin_email.dart';
import 'package:localdaily/services/models/register/validate_pin/body_validate_pin.dart';
import 'package:localdaily/services/models/register/validate_pin/result_validate_pin.dart';
import 'package:localdaily/services/models/response_data.dart';
import 'package:retrofit/http.dart';

part 'local_daily_gateway_service.g.dart';

class UrlsApi {
  static const String getDataHome = '/WebAdmin/Advertisement/GetData';
  static const String createUser = '/User/User';
  static const String login = '/Identity/Authentication';
  static const String dataUser = '/User/User/GetById';
  static const String getBanks = '/Configuration/ConfigurationBank/GetData';
  static const String createSmartContract = '/Transaction/SmartContract/CreateSmartContract';
  static const String getDocsType =
      '/Configuration/ConfigurationDocumentType/GetData';
  static const String createOffer = '/WebAdmin/Advertisement';
  static const String sendPinEmail =
      '/NotificationCenter/SendMessageEvent/SendNotificationOtp';
  static const String validateToken =
      '/NotificationCenter/SendMessageEvent/ValidationToken';
}

///WebAdmin/Advertisement create offer sell buy

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

  // @GET('/Wallet/GetByUserId')
  // Future<ResponseData<ResponseWalletByuser>> getByUserId(
  //     @Query('id') String id,
  //     );

  @GET(UrlsApi.dataUser)
  Future<ResponseData<ResultDataUser>> getUserId(
    @Query('id') String id,
  );

  @POST(UrlsApi.getBanks)
  Future<ResponseData<ResultGetBanks>> getBanks(
    @Body() Pagination bodyGetBanks,
  );

  @POST(UrlsApi.getDocsType)
  Future<ResponseData<ResultGetDocsType>> getDocsType(
    @Body() Pagination bodyGetDocsType,
  );

  @POST(UrlsApi.createOffer)
  Future<ResponseData<ResultCreateOffer>> createOffer(
    @Body() BodyOffer bodyOffer,
  );

  @POST(UrlsApi.createSmartContract)
  Future<ResponseData<ResultCreateSmartContract>> createSmartContract(
      @Body() BodyCreateSmartContract bodyCreateSmartContract,
      );

  @POST(UrlsApi.sendPinEmail)
  Future<ResponseData<ResultPinEmail>> sendPinEmail(
    @Body() BodyPinEmail bodyPin,
  );

  @POST(UrlsApi.validateToken)
  Future<ResponseData<ResultValidatePin>> validatePin(
    @Body() BodyValidatePin bodyValidatePin,
  );

// @POST(UrlsApi.login)
// Future<ResponseData<ResultLogin>> login(
//     @Body() BodyLogin bodyLogin,
//     );
}
//
// { solicitar codigo pin al correo
//   "entity": {
//   "clientId": "2955cb39-61da-46ea-b503-42cb33831c8a",
//   "numberOrEmail": "alvis.wap@gmail.com",
//   "codevia": "2955cb39-61da-46ea-b503-42cb33831c8a",
//   &
//   }
// }

// C - localTest122@gmail.com - f1010389-817c-4416-9841-21cd5373adbf
// -A 0xF92a1eA328D39d3525751E7D5e23009B1e94e8Ea
// V - juanP@gmail.com - 96a6a171-641e-4103-8909-77ccd92d41eb
// -A 0x4Cc8eE3f9874D270CA3130f694c5Be873bBF3A07
// { *loginUser
//    "identity": "juanP@gmail.com",
//   "password": "12345678",
// "signature":"T2CswFciHcSgFxh8LKRYLuz2dqwuzSCWnat/KRxACqdJhr3aLJBWObPmVyUaE6xtpAca+F1r0F06M4eh2pv6IOUcQueMO7+IRq8Kym8Py48Exu13nOcMkJhoz+o5+alZz7wuHLaAE822PCdnMkEls651+DimZ9qe16SpYVyoisU+P16jUkWBNZ/YVP3xLSNn5yUUK9paYyrKkvviNhlUKcBK0ptu5BS8edadgTXs5PRvYOP7wNp/y8RGgXRfnvNEh6as2xjjvizhEIC0GLywT9MYt/VDCXHZDk+8mpN7wVv6qn6MHEzZw6Gw1q5ObxlGTn67Ap48GjHicLYb1w5fGw==",
// "wearableId": "d9b1289a-ae98-4e86-a145-ac046a8bd5be"
// }

// { **respuesta create contract
// "isSuccess": true,
// "statusCode": 200,
// "result": {
// "id": "fa14b027-eebe-4c10-bd55-6e8469eb0da3",
// "date": "2/1/2022 9:55:31 PM",
// "transactionStatusId": "c57131ce-f78d-4a61-bf94-ce3c2601dc76",
// "hash": "0x84bdfc0160781eefe4a0a5202dab557ff3334acf768c4517c82627a0869b6d3d",
// "advertisementId": "62559e93-3c10-4b9a-811d-a0ccf9087fe0",
// "contractAddress": "0xe4917fAc19BE56E2f1Cb317B35F271acd9D6d4aF",
// "addressSeller": "0x4Cc8eE3f9874D270CA3130f694c5Be873bBF3A07",
// "addressBuyer": "0xF92a1eA328D39d3525751E7D5e23009B1e94e8Ea",
// "code": "14",
// "message": ""
// },
// "error": null
// }

// {* Create offer buy seller and buyer (0) Compra ,(1) Venta)
// "entity": {
// "idTypeAdvertisement":
//     "138412e9-4907-4d18-b432-70bdec7940c4", Compra
//      "809b4025-bf15-43f8-9995-68e3b7c53be6", venta
// "idCountry": "138412e9-4907-4d18-b432-70bdec7940c4",
// "valueToSell": "5000",
// "margin": "1",
// "termsOfTrade": "temas blck w",
// "idUserPublish": "96a6a171-641e-4103-8909-77ccd92d41eb",
// "secretSellerKey": "secreto1encryptado,secreto2encryptado"
// },
// "daysOfExpired": 7,
// "strJsonAdvertisementBanks": "[{\"bankId\": \"249bfcd0-4ab0-49a8-a886-63ce42c919a6\",\"accountNumber\": \"555555555\",\"accountTypeId\": \"c047a07c-2daf-48a7-ad49-ec447a93485b\",\"documentNumber\": \"123456789\",\"documentTypeID\" : \"c047a07c-2daf-48a7-ad49-ec447a93485b\",\"titularUserName\": \"Roger Gutierrez\"},{\"bankId\": \"249bfcd0-4ab0-49a8-a886-63ce42c919a6\",\"accountNumber\":\"101010101\",\"accountTypeId\": \"c047a07c-2daf-48a7-ad49-ec447a93485b\",\"documentTypeID\" : \"eb2e8229-13ee-4282-b053-32e7b444ea10\",\"documentNumber\": \"987654321\",\"titularUserName\": \"Carmen Martinez\"}]"
// }

// { *Create User
// "nickName": "nick",
// "firstName": "nick",
// "secondName": "nick",
// "firstLastName": "nick",
// "secondLastName": "nick",
// "dateBirth": "12/12/1921",
// "email": "test@g.com",
// "phone": "123",
// "userTypeId": "9c2f4526-5933-4404-96fc-784a87a7b674",
// "password": "Aa12345678*",
// "isActive": true
// }

// user/userInfoAditional/RateUser
// {*Calificacion Usuario
// "isSeller": true,
// "userId": "96a6a171-641e-4103-8909-77ccd92d41eb",
// "rate": "5",
// "advertisementID": "c2dedafc-7114-49f2-ae60-710724dffd4e"
// }
