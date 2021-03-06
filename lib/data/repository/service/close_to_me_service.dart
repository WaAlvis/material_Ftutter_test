import 'dart:convert';

import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/data/local/user.dart';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/favorite_model.dart';
import 'package:bogota_app/data/model/gps_model.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/data/model/request/favorite_request.dart';
import 'package:bogota_app/data/model/response/favorite_response.dart';
import 'package:bogota_app/data/model/response/places_response.dart';
import 'package:bogota_app/data/model/response_detail_model.dart';
import 'package:bogota_app/data/model/response_gps_model.dart';
import 'package:bogota_app/utils/errors/event_error.dart';
import 'package:bogota_app/utils/errors/gps_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/utils/local_data/box.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:http/http.dart' as http;

class CloseToMeService {
  Future<IdtResult<List<DataModel>?>> getPlacesCloseToMe(String coordinates, String lanUser) async {
    var queryParameters = {
      'lan': lanUser,
      'location': coordinates,

    };
    // '/place?location=4.6095552,-74.0685345'
    final uri = Uri.https(IdtConstants.url_server, '/place', queryParameters);
    final response = await http.get(uri);

    try {
      final body = json.decode(response.body);

      switch (response.statusCode) {
        case 200:
          {
            final entity = PlacesResponse.fromJson(body);
            return IdtResult.success(entity.data);
          }

        default:
          {
            final error =
            EventError('Capturar el error', response.statusCode);

            return IdtResult.failure(error);
          }
      }
    } on StateError catch (err) {
      final error = EventError(err.message, response.statusCode);

      return IdtResult.failure(error);
    }
  }

}
