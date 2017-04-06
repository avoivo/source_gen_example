// GENERATED CODE - DO NOT MODIFY BY HAND

part of models;

// **************************************************************************
// Generator: JsonSerializableGenerator2
// Target: class Example
// **************************************************************************

Example _$ExampleFromJson(Map json) => new Example(json['id'] as String,
    description: json['description'] as String)
  ..da = json['da'] as String
  ..redirectUris =
      (json['redirectUris'] as List)?.map((v0) => v0 as String)?.toList()
  ..state = json['state'] as CheckPointState
  ..createdBy = json['createdBy'] as String
  ..createdOn =
      json['createdOn'] == null ? null : DateTime.parse(json['createdOn'])
  ..modifiedBy = json['modifiedBy'] as String
  ..modifiedOn =
      json['modifiedOn'] == null ? null : DateTime.parse(json['modifiedOn']);

abstract class _$ExampleSerializerMixin {
  String get id;
  String get description;
  String get da;
  List get redirectUris;
  CheckPointState get state;
  String get createdBy;
  DateTime get createdOn;
  String get modifiedBy;
  DateTime get modifiedOn;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'description': description,
        'da': da,
        'redirectUris': redirectUris,
        'state': state,
        'createdBy': createdBy,
        'createdOn': createdOn?.toIso8601String(),
        'modifiedBy': modifiedBy,
        'modifiedOn': modifiedOn?.toIso8601String()
      };
  String getKey() => da;
  void setKey(String key) => da = key as String;
}

// **************************************************************************
// Generator: JsonSerializableGenerator2
// Target: class ExtendedExample
// **************************************************************************

ExtendedExample _$ExtendedExampleFromJson(Map json) => new ExtendedExample()
  ..createdBy = json['createdBy'] as String
  ..createdOn =
      json['createdOn'] == null ? null : DateTime.parse(json['createdOn'])
  ..id = json['id'] as String;

abstract class _$ExtendedExampleSerializerMixin {
  String get createdBy;
  DateTime get createdOn;
  String get id;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'createdBy': createdBy,
        'createdOn': createdOn?.toIso8601String(),
        'id': id
      };
  String getKey() => id;
  void setKey(String key) => id = key as String;
}
