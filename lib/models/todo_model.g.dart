// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoModel _$TodoModelFromJson(Map<String, dynamic> json) => TodoModel()
  ..objectId = json['objectId'] as String?
  ..name = json['Name'] as String?
  ..description = json['Description'] as String?
  ..fat = json['Fat'] as int?
  ..carbs = json['Carbs'] as int?
  ..protein = json['Protein'] as int?
  ..status = json['Status'] as bool?
  ..createdAt = json['CreatedAt'] as String?
  ..updatedAt = json['UpdatedAt'] as String?
  ..title = json['Title'] as String?
  ..done = json['Done'] as bool?
  ..results = (json['results'] as List<dynamic>?)
      ?.map((e) => TodoModel.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$TodoModelToJson(TodoModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('objectId', instance.objectId);
  writeNotNull('Name', instance.name);
  writeNotNull('Description', instance.description);
  writeNotNull('Fat', instance.fat);
  writeNotNull('Carbs', instance.carbs);
  writeNotNull('Protein', instance.protein);
  writeNotNull('Status', instance.status);
  writeNotNull('CreatedAt', instance.createdAt);
  writeNotNull('UpdatedAt', instance.updatedAt);
  writeNotNull('Title', instance.title);
  writeNotNull('Done', instance.done);
  writeNotNull('results', instance.results);
  return val;
}
