// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookmarkArticle _$BookmarkArticleFromJson(Map<String, dynamic> json) =>
    BookmarkArticle()
      ..author = json['author'] as String?
      ..title = json['title'] as String?
      ..description = json['description'] as String?;

Map<String, dynamic> _$BookmarkArticleToJson(BookmarkArticle instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('author', instance.author);
  writeNotNull('title', instance.title);
  writeNotNull('description', instance.description);
  return val;
}
