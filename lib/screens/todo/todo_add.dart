import 'package:flutter/material.dart';
import 'package:mobilefirst/models/todo_model.dart';
import 'package:mobilefirst/repository/todo_repositoryImpl.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ToDOAdd extends StatefulWidget {
  final String? id;
  ToDOAdd({Key? key, this.id}) : super(key: key);

  @override
  State<ToDOAdd> createState() => _ToDOAddState();
}

class _ToDOAddState extends State<ToDOAdd> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  TodoModel? todo;

  @override
  void initState() {
    getDietPlan();
    super.initState();
  }

  Future<void> getDietPlan() async {
    if (widget.id != null) {
      todo = await TodoRepositoryImpl().getDietPlan(widget.id!);
      nameController.text = todo!.name!;
      descriptionController.text = todo!.description!;
    }
  }

  Future<void> saveTodo(String title, String description) async {
    final saveTodo = ParseObject('Diet_Plans')
      ..set('Name', title)
      ..set('Description', description)
      ..set('done', false);
    await saveTodo.save();
  }

  void addToDo() async {
    if (nameController.text.trim().isEmpty &&
        descriptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Empty title"),
        duration: Duration(seconds: 2),
      ));
      return;
    }
    await saveTodo(nameController.text, descriptionController.text);
  }

  void updateToDo() async {
    if (nameController.text.trim().isEmpty &&
        descriptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Empty title"),
        duration: Duration(seconds: 2),
      ));
      return;
    }
    final updatedToDo = ParseObject('Diet_Plans')
      ..objectId = todo!.objectId
      ..set('Name', nameController.text)
      ..set('Description', descriptionController.text)
      ..set('done', false);

    await updatedToDo.save();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(right: 22, left: 22, top: 22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: "Title",
                ),
              ),
              const SizedBox(height: 22),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: "Description",
                ),
                minLines: 5,
                maxLines: 10,
              ),
              const SizedBox(height: 22),
              ElevatedButton(
                onPressed: widget.id != null ? updateToDo : addToDo,
                child: Text(
                  widget.id != null ? "Update" : "Add",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
