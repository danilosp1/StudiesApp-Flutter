import 'package:json_annotation/json_annotation.dart';

part 'motd_response.g.dart';

@JsonSerializable()
class MotdResponse {
  final String title;
  final int userId;
  final int id;
  final bool completed;

  MotdResponse({
    required this.title,
    required this.userId,
    required this.id,
    required this.completed,
  });

  factory MotdResponse.fromJson(Map<String, dynamic> json) => _$MotdResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MotdResponseToJson(this);
}