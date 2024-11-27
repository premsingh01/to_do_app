import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/modules/to_do/model/todo_model.dart';

class ToDoViewModel extends ChangeNotifier {
  ToDoViewModel() {
    getListFromSharedPref();
  }
  List<TodoModel> todoList = [];
  Future<void> getListFromSharedPref() async {
    try {
      final sharedPref = await SharedPreferences.getInstance();
      final todoListString = jsonDecode(sharedPref.getString("todoList") ?? '');
      todoList = (todoListString as List?)
              ?.map((element) => TodoModel.fromJson(element))
              .toList() ??
          [];
      notifyListeners();
      debugPrint("todoListString: $todoListString");
    } catch (e, stack) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: stack);
    }
  }

  Future<void> syncTodoToSharedPref() async {
    try {
      final sharedPref = await SharedPreferences.getInstance();
      final list = jsonEncode(todoList.map((e) => e.toJson()).toList());
      final isSaved = await sharedPref.setString("todoList", list);
      debugPrint("isSaved: $isSaved");
    } catch (e, stack) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: stack);
    }
  }

  void addTodo(TodoModel todo) {
    todoList.add(todo);
    notifyListeners();
    syncTodoToSharedPref();
  }

  void changeTodoStatus(int index, TodoModel item) {
    todoList[index] = item.copyWith(isCompleted: !item.isCompleted);
    notifyListeners();
    syncTodoToSharedPref();
  }

  void removeTodo(int index) {
    todoList.removeAt(index);
    notifyListeners();
    syncTodoToSharedPref();
  }
}
