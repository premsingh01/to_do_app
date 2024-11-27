import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:to_do_app/modules/to_do/model/todo_model.dart";
import "package:to_do_app/modules/to_do/view/widget/add_task_dialog.dart";
import "package:to_do_app/modules/to_do/view/widget/item_card.dart";
import "package:to_do_app/modules/to_do/view_model/to_do_view_model.dart";

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Colors.grey.shade100,
            appBar: AppBar(
              backgroundColor: Colors.red,
              title: const Text(
                "To-Do List",
              ),
            ),
            body: Consumer<ToDoViewModel>(
                builder: (context, ToDoViewModel todoViewModel, _) {
              return (todoViewModel.todoList.isNotEmpty)
                  ? ListView.separated(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 15, bottom: 50),
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 12,
                        );
                      },
                      itemCount: todoViewModel.todoList.length,
                      itemBuilder: (context, index) {
                        final TodoModel todoModel =
                            todoViewModel.todoList[index];
                        return ItemCard(
                          todoModel: todoModel,
                          index: index,
                        );
                      })
                  : const Center(
                      child: Text("No Todo"),
                    );
            }),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                showDialog(
                    context: context,
                    useRootNavigator: false,
                    builder: (BuildContext _) {
                      return AddTaskDialog(
                        toDoViewModel: context.read<ToDoViewModel>(),
                      );
                    });
              },
              label: const Text(
                "+ Add Task",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
       
  }
}
