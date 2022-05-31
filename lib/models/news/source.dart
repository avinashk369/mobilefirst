import 'package:json_annotation/json_annotation.dart';
part 'source.g.dart';

@JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
class Source {
  String? id;
  String? name;
  Source();
  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);
  Map<String, dynamic> toJson() => _$SourceToJson(this);
}
