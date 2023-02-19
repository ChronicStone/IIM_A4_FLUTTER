import 'package:auto_route/auto_route.dart';
import 'package:flutter_project/pages/home.dart';
import 'package:flutter_project/pages/login.dart';
import 'package:flutter_project/pages/profile.dart';
import 'package:flutter_project/pages/register.dart';
import 'package:flutter_project/pages/statistics.dart';
import 'package:flutter_project/pages/task_profile.dart';
import 'package:flutter_project/pages/tasks.dart';
import 'package:flutter_project/routing/guards.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page|Screen,Route',
  routes: <AutoRoute>[
    // app stack
    CustomRoute<String>(
        path: '/',
        name: 'HomeRouter',
        page: HomePage,
        maintainState: true,
        guards: [
          AuthGuard
        ],
        children: [
          CustomRoute(
            path: 'tasks',
            page: TasksPage,
            maintainState: false,
            transitionsBuilder: TransitionsBuilders.slideLeft,
          ),
          CustomRoute(
            path: 'profile',
            page: ProfilePage,
            transitionsBuilder: TransitionsBuilders.slideTop,
          ),
          CustomRoute(
            path: 'statistics',
            page: StatisticsPage,
            transitionsBuilder: TransitionsBuilders.slideRight,
          )
        ]),
    AutoRoute(
        page: TaskProfilePage, path: '/tasks/:taskId', guards: [AuthGuard]),
    AutoRoute(page: LoginPage, path: '/login', guards: [NoAuthGuard]),
    AutoRoute(page: RegisterPage, path: '/register', guards: [NoAuthGuard]),
    RedirectRoute(path: '*', redirectTo: '/'),
  ],
)
class $RootRouter {}
