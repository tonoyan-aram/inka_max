import 'package:json_annotation/json_annotation.dart';

part 'gratitude_entry.g.dart';

enum GratitudeTag {
  @JsonValue('health')
  health,
  @JsonValue('family')
  family,
  @JsonValue('work')
  work,
  @JsonValue('nature')
  nature,
  @JsonValue('other')
  other;

  String get displayName {
    switch (this) {
      case GratitudeTag.health:
        return 'Health';
      case GratitudeTag.family:
        return 'Family';
      case GratitudeTag.work:
        return 'Work';
      case GratitudeTag.nature:
        return 'Nature';
      case GratitudeTag.other:
        return 'Other';
    }
  }
}

@JsonSerializable()
class GratitudeEntry {
  final String id;
  final String text;
  final List<GratitudeTag> tags;
  final DateTime createdAt;
  final DateTime updatedAt;

  const GratitudeEntry({
    required this.id,
    required this.text,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GratitudeEntry.fromJson(Map<String, dynamic> json) =>
      _$GratitudeEntryFromJson(json);

  Map<String, dynamic> toJson() => _$GratitudeEntryToJson(this);

  GratitudeEntry copyWith({
    String? id,
    String? text,
    List<GratitudeTag>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GratitudeEntry(
      id: id ?? this.id,
      text: text ?? this.text,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

}
