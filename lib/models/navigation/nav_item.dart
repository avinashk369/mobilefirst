import 'package:json_annotation/json_annotation.dart';
part 'nav_item.g.dart';

@JsonSerializable(includeIfNull: false, fieldRename: FieldRename.pascal)
class NavItem {
  String? name;
  int? index;

  NavItem();
  factory NavItem.fromJson(Map<String, dynamic> json) =>
      _$NavItemFromJson(json);
  Map<String, dynamic> toJson() => _$NavItemToJson(this);
}
