import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bogota_app/data/model/response/splash_response.dart';
import 'package:bogota_app/data/model/splash_model.dart';

import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/utils/errors/filter_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

class SplashService {
  Future<IdtResult<SplashModel>> getSplash(String lanUser) async {

    var queryParameters = {
      'lan': lanUser,
    };

    final uri = Uri.https(IdtConstants.url_server, '/util/splash', queryParameters);
    print(uri);
    try {
      final response = await http.get(uri).timeout(
            Duration(seconds: 5),
          );

      try {
        switch (response.statusCode) {
          case 200:
            {
              final body = json.decode(response.body);
              final entity = SplashResponse.fromJson(body);

              return IdtResult.success(entity.data);
            }

          default:
            {
              final error = FilterError('Capturar el error', response.statusCode);

              return IdtResult.failure(error);
            }
        }
      } on StateError catch (err) {
        final error = FilterError(err.message, response.statusCode);

        return IdtResult.failure(error);
      }
    } on SocketException catch (_) {
      // A timeout occurred.
      final error = FilterError('Lost Conexion, ${_.message}', 599);

      return IdtResult.failure(error);
    } on TimeoutException catch (_) {
      // A timeout occurred.
      final error = FilterError('Lost Conexion, ${_.message}', 599);
      return IdtResult.failure(error);

    }
  }
}
