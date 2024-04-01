import 'package:hive_flutter/hive_flutter.dart';

class TaskData {
  List taskList = [];

  final _myBox = Hive.box('box');

  void startupData() {
    taskList = [
      ["Task 1", false],
      ["Task 2", false],
      ["Task 3", false],
    ];
  }

  void loadData() {
    taskList = _myBox.get("TASK_LIST");
  }

  void updateData() {
    _myBox.put("TASK_LIST", taskList);
  }
}