import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/services/auth.service.dart';
import 'package:flutter_project/types/task.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_project/config/env.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TaskService {
  TaskService(this.authService);
  final AuthService authService;

  bool isLoading = false;
  String? sortKey;
  String? sortDir;
  String? searchQuery;

  List<Task> _tasks = [];
  List<Task> get tasks =>
      _processTaskQuery(_tasks, sortKey, sortDir, searchQuery);
  List<Task> get pendingTasks => _processTaskQuery(
      _tasks.where((task) => task.status == 'Pending').toList(),
      sortKey,
      sortDir,
      searchQuery);
  List<Task> get inProgressTasks => _processTaskQuery(
      _tasks.where((task) => task.status == 'In progress').toList(),
      sortKey,
      sortDir,
      searchQuery);
  List<Task> get completedTasks => _processTaskQuery(
      _tasks.where((task) => task.status == 'Completed').toList(),
      sortKey,
      sortDir,
      searchQuery);

  getTaskById(String taskId) {
    return tasks.firstWhere((element) => element.id == taskId);
  }

  Future<bool> loadUserTasks() async {
    try {
      var response = await http.get(Uri.parse('$API_BASE_URL/tasks/'),
          headers: _getAuthHeaders());

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        _tasks =
            List<Task>.from(decoded.map((update) => Task.fromJson(update)));
        return true;
      }

      return false;
    } catch (err) {
      debugPrint(err.toString());
      return false;
    }
  }

  Future<bool> createTask(
      {required String title, String? description, List<String>? tags}) async {
    try {
      debugPrint('title: $title, description: $description');
      final response = await http.post(
        Uri.parse('$API_BASE_URL/tasks/'),
        headers: _getAuthHeaders(),
        body: jsonEncode(
            {'title': title, 'description': description, 'tags': tags}),
      );

      if (response.statusCode == 201) {
        final Task newTask = Task.fromJson(jsonDecode(response.body));
        _tasks.add(newTask);
        return true;
      }

      return false;
    } catch (err) {
      debugPrint(err.toString());
      debugPrintStack();
      return false;
    }
  }

  Future<bool> createTaskUpdate(
      {String? content, required String taskId, required int progress}) async {
    final response = await http.post(Uri.parse('$API_BASE_URL/tasks/$taskId'),
        headers: _getAuthHeaders(),
        body: jsonEncode({
          'content': content,
          'progress': progress,
        }));

    if (response.statusCode == 201) {
      final TaskUpdate update = TaskUpdate.fromJson(jsonDecode(response.body));
      Task? taskToUpdate = _tasks.firstWhere((task) => task.id == taskId);
      if (taskToUpdate != null) {
        taskToUpdate.updates.add(update);
        taskToUpdate.progress = progress;
      }

      return true;
    }

    return false;
  }

  Map<String, String> _getAuthHeaders() {
    return {
      'Authorization': 'Bearer ${authService.accessToken}',
      'Content-Type': 'application/json; charset=UTF-8',
    };
  }

  List<Task> _processTaskQuery(
      List<Task> tasks, String? sortKey, String? sortDir, String? searchQuery) {
    List<Task> updated = [...tasks];
    // Sort tasks by sortKey and sortDir
    if (sortKey != null) {
      updated.sort((a, b) {
        dynamic aValue = a.toJson()[sortKey];
        dynamic bValue = b.toJson()[sortKey];
        if (sortDir == 'DESC') {
          final tmp = aValue;
          aValue = bValue;
          bValue = tmp;
        }
        if (aValue is String && bValue is String) {
          return aValue.compareTo(bValue);
        } else if (aValue is int && bValue is int) {
          return aValue.compareTo(bValue);
        } else {
          return 0;
        }
      });
    }

    // Filter tasks by searchQuery
    if (searchQuery != null) {
      updated = updated
          .where((task) =>
              task.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
              task.description
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()))
          .toList();
    }

    return updated;
  }
}
