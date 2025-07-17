// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'motd_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MotdResponse _$MotdResponseFromJson(Map<String, dynamic> json) => MotdResponse(
      title: json['title'] as String,
      id: (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$MotdResponseToJson(MotdResponse instance) =>
    <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
    };
