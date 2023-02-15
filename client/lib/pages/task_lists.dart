import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TasksListPage extends StatefulWidget {
  @override
  _TasksListPageState createState() => _TasksListPageState();
}

class _TasksListPageState extends State<TasksListPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connectez-vous'),
      ),
      body: const Center(
        child: Text('Home'),
      )
    );
  }
}