// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsModel _$NewsModelFromJson(Map<String, dynamic> json) => NewsModel()
  ..status = json['status'] as String?
  ..totalResults = json['total_results'] as int?
  ..articles = (json['articles'] as List<dynamic>?)
      ?.map((e) => Articles.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$NewsModelToJson(NewsModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('status', instance.status);
  writeNotNull('total_results', instance.totalResults);
  writeNotNull('articles', instance.articles);
  return val;
}
