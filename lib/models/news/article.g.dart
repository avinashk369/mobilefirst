// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Articles _$ArticlesFromJson(Map<String, dynamic> json) => Articles()
  ..source = json['source'] == null
      ? null
      : Source.fromJson(json['source'] as Map<String, dynamic>)
  ..author = json['author'] as String?
  ..title = json['title'] as String?
  ..description = json['description'] as String?
  ..url = json['url'] as String?
  ..urlToImage = json['url_to_image'] as String?
  ..publishedAt = json['published_at'] as String?
  ..content = json['content']
  ..isBookmarked = json['is_bookmarked'] as bool;

Map<String, dynamic> _$ArticlesToJson(Articles instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('source', instance.source);
  writeNotNull('author', instance.author);
  writeNotNull('title', instance.title);
  writeNotNull('description', instance.description);
  writeNotNull('url', instance.url);
  writeNotNull('url_to_image', instance.urlToImage);
  writeNotNull('published_at', instance.publishedAt);
  writeNotNull('content', instance.content);
  val['is_bookmarked'] = instance.isBookmarked;
  return val;
}
