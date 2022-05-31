import 'package:json_annotation/json_annotation.dart';

import 'source.dart';
part 'article.g.dart';

@JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
class Articles {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  dynamic content;
  bool isBookmarked = false;
  Articles();
  factory Articles.fromJson(Map<String, dynamic> json) =>
      _$ArticlesFromJson(json);
  Map<String, dynamic> toJson() => _$ArticlesToJson(this);
}
