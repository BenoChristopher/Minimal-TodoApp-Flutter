import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class TodoTile extends StatelessWidget {
  TodoTile(
      {super.key,
      required this.taskName,
      required this.taskCompleted,
      required this.onChanged,
      required this.deleteTask});

  final String taskName;

  final bool taskCompleted;

  Function(bool?)? onChanged;

  Function(BuildContext)? deleteTask;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slidable(
          endActionPane: ActionPane(motion: StretchMotion(), children: [
            SlidableAction(
              onPressed: deleteTask,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(12),
            )
          ]),
          child: Container(
            child: Padding(
              padding:
                  EdgeInsets.only(left: 25.0, right: 25.0, top: 25, bottom: 25),
              child: Row(
                children: [
                  Checkbox(
                    value: taskCompleted,
                    onChanged: onChanged,
                    activeColor: Colors.deepPurple,
                  ),
                  Text(
                    taskName,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        decoration: taskCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Divider between active and completed tasks
        // Divider(indent: 10, thickness: 2, color: Colors.grey[300]),
        // Container(
        //   width: 360,
        //   height: 2,
        //   decoration: BoxDecoration(color: Colors.black12),
        // )
      ],
    );
  }
}
