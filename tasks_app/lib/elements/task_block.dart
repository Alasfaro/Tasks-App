import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TaskBlock extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  TaskBlock({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 35),
      child: Dismissible(
        key: UniqueKey(), 
        direction: DismissDirection.endToStart, 
        onDismissed: (direction) {
          if (deleteFunction != null) {
            deleteFunction!(context);
          }
        },
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            color: Colors.red, 
            borderRadius: BorderRadius.circular(12), 
          ), 
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.delete, color: Colors.white),
              Text('Delete', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              SizedBox(width: 20),
            ],
          ),
        ),
        child: Opacity(
          opacity: taskCompleted ? 0.5 : 1.0,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 110, 154, 219),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Checkbox(
                  value: taskCompleted,
                  onChanged: onChanged,
                  activeColor: Colors.black,
                ),
                Text(
                  taskName,
                  style: TextStyle(
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}