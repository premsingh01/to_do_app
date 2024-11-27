import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/modules/to_do/model/todo_model.dart';
import 'package:to_do_app/modules/to_do/view_model/to_do_view_model.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.index, required this.todoModel});
  final TodoModel todoModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
                child: Text(
                  todoModel.isCompleted ? "Completed" : "Ongoing",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: todoModel.isCompleted
                        ? Colors.green
                        : Colors.red, // show red when on Ongoing
                  ),
                ),
              ),
            ),
          ],
        ),
        ListTile(
          tileColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          leading: Checkbox(
            value: todoModel.isCompleted,
            onChanged: (bool? value) {
              context.read<ToDoViewModel>().changeTodoStatus(index, todoModel);
            },
          ),
          title: Text(
            todoModel.title,
            style: TextStyle(
                decoration:
                    todoModel.isCompleted ? TextDecoration.lineThrough : null,
                fontSize: 15),
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
              size: 20,
            ),
            onPressed: () {
              context.read<ToDoViewModel>().removeTodo(index);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Task Deleted')),
              );
            },
          ),
        ),
      ],
    );
  }
}
