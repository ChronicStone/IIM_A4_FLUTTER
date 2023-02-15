import 'package:flutter_project/pages/login.dart';
import 'package:flutter_project/pages/register.dart';
import 'package:flutter_project/pages/task_lists.dart';

final appRoutes = {
  '/': (context) => TasksListPage(),
  '/login': (context) => LoginPage(),
  '/register': (context) => RegisterPage(),
};