// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'motd_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MotdResponse _$MotdResponseFromJson(Map<String, dynamic> json) => MotdResponse(
      title: json['title'] as String,
      userId: (json['userId'] as num).toInt(),
      id: (json['id'] as num).toInt(),
      completed: json['completed'] as bool,
    );

Map<String, dynamic> _$MotdResponseToJson(MotdResponse instance) =>
    <String, dynamic>{
      'title': instance.title,
      'userId': instance.userId,
      'id': instance.id,
      'completed': instance.completed,
    };
