import "package:flutter/material.dart";
import "package:to_do_app/modules/to_do/model/todo_model.dart";
import "package:to_do_app/modules/to_do/view_model/to_do_view_model.dart";

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({
    super.key,
    required this.toDoViewModel,
  });

  final ToDoViewModel toDoViewModel;

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  TextEditingController textController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text(
        'New Task Title',
        style: TextStyle(fontSize: 18),
      ),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: textController,
              decoration: InputDecoration(
                isDense: true,
                hintText: 'New task title...',
                hintStyle: TextStyle(
                    color: Colors.grey.shade500, fontWeight: FontWeight.w400),
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                return (value?.isNotEmpty ?? false)
                    ? null
                    : "Enter valid value";
              },
              onTapOutside: (val) {
                FocusScope.of(context).unfocus();
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.red)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Close',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (!(formKey.currentState?.validate() ?? false)) {
                      return;
                    }

                    debugPrint('User Input: ${textController.text}');
                    widget.toDoViewModel.addTodo(TodoModel(
                        title: textController.text, isCompleted: false));
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
