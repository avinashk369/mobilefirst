import 'package:json_annotation/json_annotation.dart';
part 'todo_model.g.dart';

@JsonSerializable(includeIfNull: false, fieldRename: FieldRename.pascal)
class TodoModel {
  @JsonKey(name: "objectId")
  String? objectId;
  String? name;
  String? description;
  int? fat;
  int? carbs;
  int? protein;
  bool? status;
  String? createdAt;
  String? updatedAt;
  String? title;
  bool? done;
  @JsonKey(name: 'results')
  List<TodoModel>? results;

  TodoModel();
  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);
  Map<String, dynamic> toJson() => _$TodoModelToJson(this);
}


// const String keyTodo = 'todo';
// const String keyName = 'name';
// const String keyDescription = 'desc';
// const String keyStatus = 'status';

// @JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
// class TodoModel extends ParseObject implements ParseCloneable {
//   TodoModel() : super(keyTodo);
//   TodoModel.clone() : this();

//   @override
//   TodoModel clone(Map<String, dynamic> map) => TodoModel.clone()..fromJson(map);

//   String get name => get<String>(keyName)!;
//   set name(String name) => set<String>(keyName, name);

//   String get description => get<String>(keyDescription)!;
//   set description(String description) => set<String>(keyDescription, name);

//   bool get status => get<bool>(keyStatus)!;

//   set status(bool status) => set<bool>(keyStatus, status);
// }
