import 'package:json_annotation/json_annotation.dart';

part 'bookmark_article.g.dart';

@JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
class BookmarkArticle {
  String? author;
  String? title;
  String? description;

  BookmarkArticle();
  factory BookmarkArticle.fromJson(Map<String, dynamic> json) =>
      _$BookmarkArticleFromJson(json);
  Map<String, dynamic> toJson() => _$BookmarkArticleToJson(this);
}
