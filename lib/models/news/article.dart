import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'source.dart';
part 'article.g.dart';

@JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
class Articles extends Equatable {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  @JsonKey(name: "urlToImage")
  String? urlToImage;
  String? publishedAt;
  dynamic content;
  int? status;
  int? id;
  Articles(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content,
      this.status,
      this.id});

  Articles copyWith(
      {Source? source,
      String? author,
      String? title,
      String? description,
      String? url,
      String? urlToImage,
      String? publishedAt,
      dynamic content,
      int? status,
      int? id}) {
    return Articles(
      source: source ?? this.source,
      author: author ?? this.author,
      title: title ?? this.title,
      description: description ?? this.description,
      url: url ?? this.url,
      urlToImage: urlToImage ?? this.urlToImage,
      publishedAt: publishedAt ?? this.publishedAt,
      content: content ?? this.content,
      status: status ?? this.status,
      id: id ?? this.id,
    );
  }

  factory Articles.fromJson(Map<String, dynamic> json) =>
      _$ArticlesFromJson(json);
  Map<String, dynamic> toJson() => _$ArticlesToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [
        source,
        author,
        title,
        description,
        url,
        urlToImage,
        publishedAt,
        content,
        status,
        id
      ];
}
