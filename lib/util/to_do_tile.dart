import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskDone;
  final Function(bool?)? onCheck;
  final void Function(BuildContext)? deleteTask;
  final void Function(BuildContext)? editeTask;
  const ToDoTile(
      {super.key,
      required this.taskName,
      required this.taskDone,
      required this.onCheck,
      required this.deleteTask,
      required this.editeTask});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 10),
      child: Slidable(
        //right to left
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(12),
            onPressed: deleteTask,
            icon: Icons.delete,
            backgroundColor: Colors.red[300]!,
          )
        ]),

        //left to right
        startActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(12),
            onPressed: editeTask,
            icon: Icons.edit,
            backgroundColor: Colors.red[300]!,
          )
        ]),

        // task container
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: Colors.deepPurple[400],
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Checkbox(
                shape: const CircleBorder(),
                value: taskDone,
                onChanged: onCheck,
                checkColor: Colors.deepPurple[400],
                activeColor: Colors.deepPurple[100],
              ),
              Text(
                taskName,
                style: TextStyle(
                    decoration: taskDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              )
            ],
          ),
        ),
      ),
    );
  }
}
