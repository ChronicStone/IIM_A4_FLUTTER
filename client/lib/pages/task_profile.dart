import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/components/loading_overlay.dart';
import 'package:flutter_project/components/task_card.dart';
import 'package:flutter_project/components/task_update_card.dart';
import 'package:flutter_project/components/task_update_form.dart';
import 'package:flutter_project/components/toast.dart';
import 'package:flutter_project/services/task.service.dart';
import 'package:flutter_project/types/task.dart';
import 'package:flutter_project/utils/share.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:timelines/timelines.dart';

class TaskProfilePage extends StatefulWidget {
  TaskProfilePage({@PathParam('taskId') this.taskId});
  final String? taskId;

  @override
  _TaskProfileState createState() => _TaskProfileState();
}

class _TaskProfileState extends State<TaskProfilePage> {
  final taskService = GetIt.instance<TaskService>();
  Task get task =>
      taskService.tasks.firstWhere((element) => element.id == widget.taskId);

  @override
  void initState() {
    var _task = taskService.getTaskById(widget.taskId ?? '');
    if (_task == null) {
      Navigator.of(context).pop();
    }
    super.initState();
  }

  void postTaskUpdate({String? content, required int progress}) async {
    final loadingOverlay = LoadingOverlay.of(context);
    var showToast = ToastBuilder(context);

    debugPrint('progress: $progress');
    debugPrint('content: $content');

    loadingOverlay.show();
    bool result = await taskService.createTaskUpdate(
        taskId: widget.taskId ?? '', content: content, progress: progress);
    loadingOverlay.hide();
    if (result) {
      showToast(
          title: 'Operation successful',
          content: 'The task update have been created',
          type: ToastType.success);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TASK DETAILS'),
      ),
      floatingActionButton: SpeedDial(
        backgroundColor: Theme.of(context).colorScheme.primary,
        icon: Icons.settings,
        children: [
          SpeedDialChild(
              label: 'Update task',
              child: const Icon(Icons.add),
              onTap: () {
                showModalBottomSheet<void>(
                    isScrollControlled: true,
                    useRootNavigator: true,
                    context: context,
                    builder: (BuildContext context) {
                      return Scaffold(
                          body: TaskUpdateForm(
                        currentProgress: task.progress,
                        onSubmit: postTaskUpdate,
                      ));
                    });
              }),
          SpeedDialChild(
              label: 'Share task',
              child: const Icon(Icons.share),
              onTap: () {
                launchEmailApp(context,
                    emailAddress: 'recipient@example.com',
                    body:
                        'TITLE: ${task.title} \n\n DESCRIPTION: ${task.description}',
                    subject: 'TASK MANAGER | ${task.title}');
              })
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          child: Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TaskCard(task),
              if (task.updates.length > 0)
                Flexible(
                    child: Timeline.tileBuilder(
                  theme: TimelineThemeData(
                    indicatorPosition: 0,
                    nodePosition: 0,
                    color: Color(0xffc2c5c9),
                    connectorTheme: ConnectorThemeData(
                      thickness: 3.0,
                    ),
                  ),
                  padding: EdgeInsets.only(top: 20.0),
                  builder: TimelineTileBuilder.connected(
                    connectionDirection: ConnectionDirection.before,
                    indicatorBuilder: (context, index) {
                      return DotIndicator(
                        color: Theme.of(context).colorScheme.primary,
                      );
                    },
                    connectorBuilder: (context, index, connectorType) {
                      return SolidLineConnector(
                        indent: connectorType == ConnectorType.start ? 0 : 2.0,
                        endIndent: connectorType == ConnectorType.end ? 0 : 2.0,
                        color: Theme.of(context).colorScheme.primary,
                      );
                    },
                    contentsBuilder: (_, index) {
                      final update = task.updates[index];
                      return Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: [
                                    TextSpan(text: 'Progress updated to '),
                                    TextSpan(
                                      text: '${update.progress}%',
                                      style: TextStyle(
                                        color: update.color,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (!update.content.isEmpty &&
                                  update.content != null)
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 10),
                                    padding: EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surfaceVariant,
                                    ),
                                    child: Text(update.content),
                                  ),
                                ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                  DateFormat.yMMMMd()
                                      .format(DateTime.parse(update.createdAt)),
                                  style:
                                      TextStyle(color: Colors.grey.shade400)),
                              SizedBox(
                                height: 50,
                              )
                            ]),
                      );
                    },
                    itemCount: task.updates.length,
                  ),
                ))
              else
                Container(
                  height: 150,
                  child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.inbox,
                            size: 40,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'No updates',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 20)
                        ]),
                  ),
                )
            ],
          )),
    );
  }
}
