import 'package:json_annotation/json_annotation.dart';

part 'motd_response.g.dart';

@JsonSerializable()
class MotdResponse {
  final String title;
  final int id;

  MotdResponse({
    required this.title,
    required this.id
  });

  factory MotdResponse.fromJson(Map<String, dynamic> json) => _$MotdResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MotdResponseToJson(this);
}