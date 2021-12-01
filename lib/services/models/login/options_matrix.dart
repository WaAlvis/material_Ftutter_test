import 'package:json_annotation/json_annotation.dart';


part 'options_matrix.g.dart';

@JsonSerializable()
class OptionsMatrix{

  OptionsMatrix();
  factory OptionsMatrix.fromJson(Map<String, dynamic> json) =>
      _$OptionsMatrixFromJson(json);






  Map<String, dynamic> toJson() => _$OptionsMatrixToJson(this);
}
