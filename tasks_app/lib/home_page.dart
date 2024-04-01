import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'elements/task_content.dart';
import 'elements/task_block.dart';
import 'elements/task_data.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _myBox = Hive.box('box');
  TaskData data = TaskData();

  @override
  void initState() {
    if (_myBox.get("TASK_LIST") == null) {
      data.startupData();
    } else {
      data.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();

  void checkTask(bool? value, int index) {
    setState(() {
      data.taskList[index][1] = !data.taskList[index][1];
    });
    data.updateData();
  }

  void createTask() {
    showDialog(
      context: context,
      builder: (context) {
        return TaskContents(
          controller: _controller,
          onSave: () {
            setState(() {
              data.taskList.add([_controller.text, false]);
              _controller.clear();
            });
            Navigator.of(context).pop();
            data.updateData();
          },
          onCancel: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      data.taskList.removeAt(index);
    });
    data.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 151, 214, 230),
      appBar: AppBar(
        title: const Text('Tasks'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 110, 154, 219),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.edit_note)
        ,)
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createTask,
        backgroundColor: Color.fromARGB(255, 110, 154, 219),
        child: const Icon(Icons.add, color: Colors.black,),
      ),
      body: ListView.builder(
        itemCount: data.taskList.length,
        itemBuilder: (context, index) {
          return TaskBlock(
            taskName: data.taskList[index][0],
            taskCompleted: data.taskList[index][1],
            onChanged: (value) {
              checkTask(value, index);
            },
            deleteFunction: (context) {
              deleteTask(index);
            },
          );
        },
      ),
    );
  }
}