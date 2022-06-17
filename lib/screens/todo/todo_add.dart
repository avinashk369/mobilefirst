import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ToDOAdd extends StatelessWidget {
  ToDOAdd({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> saveTodo(String title, String description) async {
      final todo = ParseObject('Diet_Plans')
        ..set('Name', title)
        ..set('Description', description)
        ..set('done', false);
      await todo.save();
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
                onPressed: addToDo,
                child: const Text("Add"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
