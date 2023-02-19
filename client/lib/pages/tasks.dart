import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/components/loading_overlay.dart';
import 'package:flutter_project/components/task_card.dart';
import 'package:flutter_project/components/task_form.dart';
import 'package:flutter_project/components/task_query_dialog.dart';
import 'package:flutter_project/components/toast.dart';
import 'package:flutter_project/routing/router.gr.dart';
import 'package:flutter_project/services/task.service.dart';
import 'package:flutter_project/types/task.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeletons/skeletons.dart';
import 'package:intl/intl.dart';

class TasksPage extends StatefulWidget {
  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage>
    with SingleTickerProviderStateMixin, RouteAware {
  late TabController _tabController;
  final taskService = GetIt.instance<TaskService>();

  void loadTasks([RefreshController? controller]) async {
    debugPrint('Loading tasks ...');
    if (controller != null) {
      setState(() {
        taskService.isLoading = true;
      });
    }

    await taskService.loadUserTasks();
    setState(() {
      taskService.isLoading = false;
    });

    if (controller != null) {
      controller.refreshCompleted();
      controller.loadComplete();
    }
  }

  void createTask(
      {required String title, String? description, List<String>? tags}) async {
    final loadingOverlay = LoadingOverlay.of(context);
    var showToast = ToastBuilder(context);

    loadingOverlay.show();
    bool result = await taskService.createTask(
        title: title, description: description, tags: tags);
    loadingOverlay.hide();
    if (result) {
      showToast(
          title: 'Operation successful',
          content: 'The task have been created',
          type: ToastType.success);
    }
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  void setTaskQuery(
      {required String? searchQuery,
      required String? sortKey,
      required String? sortDir}) {
    debugPrint('QUERY : $searchQuery');
    debugPrint('KEY : $sortKey');
    debugPrint('DIR : $sortDir');
    setState(() {
      taskService.searchQuery = searchQuery;
      taskService.sortDir = sortDir;
      taskService.sortKey = sortKey;
    });
  }

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
    loadTasks();
  }

  @override
  void didPop() {
    super.didPop();
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: SpeedDial(
          backgroundColor: Theme.of(context).colorScheme.primary,
          icon: Icons.settings,
          children: [
            SpeedDialChild(
                label: 'Create task',
                child: const Icon(Icons.add),
                onTap: () {
                  showModalBottomSheet<void>(
                      isScrollControlled: true,
                      useRootNavigator: true,
                      context: context,
                      builder: (BuildContext context) {
                        return Scaffold(
                            body: TaskForm(
                          onSubmit: createTask,
                        ));
                      });
                }),
            SpeedDialChild(
                label: 'Filter / sort',
                child: const Icon(Icons.sort_by_alpha),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return FilterTasksModal(
                        onSearch: setTaskQuery,
                        searchQuery: taskService.searchQuery,
                        sortDir: taskService.sortDir,
                        sortKey: taskService.sortKey,
                      );
                    },
                  );
                })
          ],
        ),
        body: Column(
          children: [
            Container(
              color: Theme.of(context).colorScheme.surfaceVariant,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  TabBar(
                    isScrollable: true,
                    controller: _tabController,
                    tabs: [
                      Tab(text: 'My tasks (${taskService.tasks.length})'),
                      Tab(text: 'Pending (${taskService.pendingTasks.length})'),
                      Tab(
                          text:
                              'In progress (${taskService.inProgressTasks.length})'),
                      Tab(
                          text:
                              'Completed (${taskService.completedTasks.length})'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            if (taskService.isLoading)
              Container(
                height: MediaQuery.of(context).size.height - 200,
                child: SkeletonListView(
                  itemCount: 20,
                ),
              )
            else
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildTaskList(taskService.tasks, loadTasks, context),
                    _buildTaskList(
                        taskService.pendingTasks, loadTasks, context),
                    _buildTaskList(
                        taskService.inProgressTasks, loadTasks, context),
                    _buildTaskList(
                        taskService.completedTasks, loadTasks, context),
                  ],
                ),
              )
          ],
        ));
  }

  Widget _buildTaskList(
      List<Task> tasks, Function(RefreshController) onRefresh, context) {
    final RefreshController refreshController =
        RefreshController(initialRefresh: false);
    return SmartRefresher(
      enablePullUp: true,
      controller: refreshController,
      onRefresh: () {
        onRefresh(refreshController);
      },
      child: tasks.isEmpty
          ? Center(
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
                      'No tasks',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 20)
                  ]),
            )
          : ListView.builder(
              itemCount: tasks.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Material(
                  type: MaterialType.transparency,
                  child: GestureDetector(
                      onTap: () {
                        AutoRouter.of(context)
                            .push(TaskProfileRoute(taskId: task.id));
                      },
                      child: Container(
                          margin: const EdgeInsets.all(10),
                          child: TaskCard(task))),
                );
              },
            ),
    );
  }
}
