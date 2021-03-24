import 'dart:convert';
import 'package:bogota_app/data/model/places_model.dart';
import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/utils/errors/unmissable_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:http/http.dart' as http;
import 'response/places_response.dart';

class UnmissableService {
  Future<IdtResult<List<DataPlacesModel>?>> getPlaces() async {

    // final uri = Uri.https(IdtConstants.url_server, '/event', queryParameters);
    final uri = Uri.https(IdtConstants.url_server, '/place/unmissable');

    final response = await http.get(uri);

    try {
      final body = json.decode(response.body);

      print('Response: $body');
      print('Response: ${response.statusCode}');

      switch (response.statusCode) {
        case 200:
          {
            final entity = PlacesResponse.fromJson(body);

            return IdtResult.success(entity.data);
          }

        default:
          {
            final error =
                UnmissableError('Capturar el error', response.statusCode);

            return IdtResult.failure(error);
          }
      }
    } on StateError catch (err) {
      final error = UnmissableError(err.message, response.statusCode);

      return IdtResult.failure(error);
    }
  }
}
