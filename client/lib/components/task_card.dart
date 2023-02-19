import 'package:flutter/material.dart';
import 'package:flutter_project/types/task.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  TaskCard(this.task);
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context)
              .colorScheme
              .surfaceVariant
              .withOpacity(0.6), //.withOpacity(0.4),
          border: Border.all(color: task.color, width: 1.0)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title.toUpperCase(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      DateFormat.yMMMMd()
                          .format(DateTime.parse(task.createdAt)),
                      style: TextStyle(color: Colors.grey.shade400),
                    ),
                  ]),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: task.color.withOpacity(0.4),
                border: Border.all(color: task.color, width: 1.0),
              ),
              child: Text(task.status),
            )
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Divider(
          color: Colors.white.withOpacity(0.5),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Description :'),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(task.description == '' ? 'N/A' : task.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(color: Colors.grey.shade400)),
                    const SizedBox(
                      height: 8,
                    ),
                  ]),
            ),
            SizedBox(
              width: 10,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 60,
                  width: 60,
                  child: CircularProgressIndicator(
                    value: task.progress / 100,
                    backgroundColor: Colors.grey,
                    strokeWidth: 4,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
                Text(
                  "${(task.progress).toInt()}%",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Divider(
          color: Colors.white.withOpacity(0.5),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Number of updates :'),
            Text('${task.updates.length ?? 0}')
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Last update :'),
            Text('N/A', style: TextStyle(color: Colors.grey.shade400))
          ],
        ),
        if (task.tags.length > 0)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.white.withOpacity(0.5),
              ),
              const SizedBox(
                height: 10,
              ),
              Wrap(
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                spacing: 10,
                runSpacing: 10,
                children: List.generate(task.tags.length ?? 0, (index) {
                  String item = (task.tags ?? [])[index];
                  return Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.6),
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 1.0)),
                    child: Text(item),
                  );
                }),
              ),
            ],
          )
      ]),
    );
  }
}
