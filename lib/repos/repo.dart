import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/todo_model.dart';

class TodoRepository extends ChangeNotifier {
  // Todo list
  final List<TodoModel> _todoList = [];
  // Start Date for date picker box display purpose
  String _startDate = 'Select a date';
  String _endDate = 'Select a date';
  String _remark = '';

// To add new todo item into todo list
  addTodo(TodoModel todoList) {
    _todoList.add(todoList);
    notifyListeners();
  }

// To update existing todo item in todo list
  updateTodo(TodoModel todoList, int index) {
    _todoList[index] = todoList;
    notifyListeners();
  }

// To update start date for date picker box display purpose
  updateStartDate(String date) {
    _startDate = date;
    notifyListeners();
  }

// To update end date for date picker box display purpose
  updateEndDate(String date) {
    _endDate = date;
    notifyListeners();
  }

  updateRemark(String remark) {
    _remark = remark;
    notifyListeners();
  }

// To update checkbox of existing todo item in todo list
  updateTodoCheckbox(bool iscomplete, int index) {
    _todoList[index].iscomplete = iscomplete;
    notifyListeners();
  }

// To return start date for date picker box display purpose
  returnDisplayStartDate() {
    return _startDate;
  }

// To return end date for date picker box display purpose
  returnDisplayEndDate() {
    return _endDate;
  }

  returnDisplayRemark() {
    return _remark;
  }

// To return todo list
  returnAllTodo() {
    return _todoList;
  }
}
