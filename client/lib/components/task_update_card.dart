import 'package:flutter/material.dart';
import 'package:flutter_project/types/task.dart';
import 'package:intl/intl.dart';

class TaskUpdateCard extends StatelessWidget {
  final TaskUpdate taskUpdate;
  TaskUpdateCard(this.taskUpdate);

  @override
  Widget build(context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(text: 'Progress updated to '),
              TextSpan(
                text: '${taskUpdate.progress} %',
                style: const TextStyle(
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
        if (!taskUpdate.content.isEmpty && taskUpdate.content != null)
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceTint,
            ),
          ),
        SizedBox(
          height: 10,
        ),
        Text(DateFormat.yMMMMd().format(DateTime.parse(taskUpdate.createdAt)),
            style: TextStyle(color: Colors.grey.shade400))
      ],
    );
  }
}
