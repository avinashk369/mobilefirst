import 'package:json_annotation/json_annotation.dart';

import 'article.dart';
part 'news_model.g.dart';

@JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
class NewsModel {
  String? status;
  int? totalResults;
  List<Articles>? articles;
  NewsModel();
  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);
  Map<String, dynamic> toJson() => _$NewsModelToJson(this);
}
