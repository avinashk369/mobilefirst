// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nav_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NavItem _$NavItemFromJson(Map<String, dynamic> json) => NavItem()
  ..name = json['Name'] as String?
  ..index = json['Index'] as int?;

Map<String, dynamic> _$NavItemToJson(NavItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('Index', instance.index);
  return val;
}
