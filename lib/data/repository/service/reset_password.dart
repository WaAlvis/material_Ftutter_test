import 'dart:convert';

import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/data/model/response_model.dart';
import 'package:bogota_app/data/model/response_model_reset_password.dart';
import 'package:bogota_app/utils/errors/unmissable_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:http/http.dart' as http;

class ResetPasswordService {
  Future<IdtResult<ResponseResetPasswordModel?>> resetPassword(
      String email) async {
    // final uri = Uri.https(IdtConstants.url_server, '/event', queryParameters);
    final uri = Uri.https(IdtConstants.url_server, '/auth/reset_password');

    final response = await http.post(uri, body: {"emailto": email});

    try {
      final body = json.decode(response.body);
      switch (response.statusCode) {
        case 200:
          {
            final entity = ResponseResetPasswordModel.fromJson(body);
            return IdtResult.success(entity);
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
