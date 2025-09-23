// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gratitude_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GratitudeEntry _$GratitudeEntryFromJson(Map<String, dynamic> json) =>
    GratitudeEntry(
      id: json['id'] as String,
      text: json['text'] as String,
      tags: (json['tags'] as List<dynamic>)
          .map((e) => $enumDecode(_$GratitudeTagEnumMap, e))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$GratitudeEntryToJson(GratitudeEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'tags': instance.tags.map((e) => _$GratitudeTagEnumMap[e]!).toList(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$GratitudeTagEnumMap = {
  GratitudeTag.health: 'health',
  GratitudeTag.family: 'family',
  GratitudeTag.work: 'work',
  GratitudeTag.nature: 'nature',
  GratitudeTag.other: 'other',
};
