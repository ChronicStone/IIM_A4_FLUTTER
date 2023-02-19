import 'package:flutter/material.dart';

enum TaskType { professional, personnal }

Color getStatusColor(String status) {
  return status == 'Pending'
      ? Colors.blueGrey.shade300
      : status == 'In progress'
          ? Colors.pink.shade500
          : Colors.green.shade400;
}

String getStatusLabel(int progress) {
  return progress >= 100
      ? 'Completed'
      : progress >= 1
          ? 'In progress'
          : 'Pending';
}

class Task {
  final String? id;
  final String title;
  final String description;
  final List<String> tags;
  final String createdAt;
  final String updatedAt;
  int progress;
  final List<TaskUpdate> updates;

  TaskUpdate? get lastUpdate => updates.last;
  String get status => getStatusLabel(progress);
  int get totalUpdates => updates.length;
  Color get color => getStatusColor(status);

  Task(
      {this.id,
      required this.tags,
      required this.title,
      required this.description,
      required this.updatedAt,
      required this.createdAt,
      required this.progress,
      required this.updates});

  factory Task.fromJson(Map<String, dynamic> json) {
    var tagList = (json['tags'] ?? []) as List<dynamic>;
    var tagStrings = tagList.cast<String>().toList();

    var updateList = (json['updates'] ?? []) as List<dynamic>;
    var updates =
        updateList.map((update) => TaskUpdate.fromJson(update)).toList();

    return Task(
      id: json['_id'],
      tags: tagStrings,
      title: json['title'],
      description: json['description'],
      updatedAt: json['updatedAt'],
      createdAt: json['createdAt'],
      progress: json['progress'],
      updates: updates,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['tags'] = this.tags;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['progress'] = this.progress;
    data['updates'] = this.updates.map((update) => update.toJson()).toList();
    return data;
  }
}

class TaskUpdate {
  final String? id;
  final String content;
  final int progress;
  final String createdAt;

  String get newStatus => getStatusLabel(progress);
  Color get color => getStatusColor(newStatus);

  TaskUpdate(
      {this.id,
      required this.content,
      required this.progress,
      required this.createdAt});

  factory TaskUpdate.fromJson(Map<String, dynamic> json) {
    return TaskUpdate(
      id: json['_id'],
      content: json['content'],
      progress: json['progress'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'content': content,
      'progress': progress,
      'createdAt': createdAt,
    };
  }
}
