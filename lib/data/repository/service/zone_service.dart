import 'dart:convert';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/data/model/response/places_response.dart';
import 'package:bogota_app/utils/errors/unmissable_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/utils/local_data/box.dart';
import 'package:http/http.dart' as http;

class ZonesService {
  Future<IdtResult<List<DataModel>?>> getZones(String lanUser) async {

    var queryParameters = {
      'lan': lanUser,
    };
    final uri = Uri.https(IdtConstants.url_server, '/zone',queryParameters);
    final response = await http.get(uri);

    try {
      final body = json.decode(response.body);

      switch (response.statusCode) {
        case 200:
          {
            final entity = PlacesResponse.fromJson(body);
          print('Zone Status: ${entity.status}');
            return IdtResult.success(entity.data);
          }

        default:
          {
            final error = UnmissableError('Capturar el error', response.statusCode);

            return IdtResult.failure(error);
          }
      }
    } on StateError catch (err) {
      final error = UnmissableError(err.message, response.statusCode);

      return IdtResult.failure(error);
    }
  }
}
