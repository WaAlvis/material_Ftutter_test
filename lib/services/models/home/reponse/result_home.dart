import 'package:json_annotation/json_annotation.dart';
import 'package:localdaily/services/models/home/reponse/data.dart';
import 'package:localdaily/services/models/login/token_login.dart';

part 'result_home.g.dart';

@JsonSerializable()
class ResultHome{

  ResultHome({
    required this.data,
    required this.totalItems,
    required this.totalPages,

  });
  factory ResultHome.fromJson(Map<String, dynamic> json) =>
      _$ResultHomeFromJson(json);

  // TokenLogin tokenData;
  // String? user;
  List<Data> data;
  int totalItems;
  int totalPages;




  Map<String, dynamic> toJson() => _$ResultHomeToJson(this);
}