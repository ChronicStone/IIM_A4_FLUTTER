// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;

import '../pages/home.dart' as _i1;
import '../pages/login.dart' as _i3;
import '../pages/profile.dart' as _i6;
import '../pages/register.dart' as _i4;
import '../pages/statistics.dart' as _i7;
import '../pages/task_profile.dart' as _i2;
import '../pages/tasks.dart' as _i5;
import 'guards.dart' as _i10;

class RootRouter extends _i8.RootStackRouter {
  RootRouter({
    _i9.GlobalKey<_i9.NavigatorState>? navigatorKey,
    required this.authGuard,
    required this.noAuthGuard,
  }) : super(navigatorKey);

  final _i10.AuthGuard authGuard;

  final _i10.NoAuthGuard noAuthGuard;

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    HomeRouter.name: (routeData) {
      return _i8.CustomPage<String>(
        routeData: routeData,
        child: _i1.HomePage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    TaskProfileRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<TaskProfileRouteArgs>(
          orElse: () =>
              TaskProfileRouteArgs(taskId: pathParams.optString('taskId')));
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.TaskProfilePage(taskId: args.taskId),
      );
    },
    LoginRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.LoginPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.RegisterPage(),
      );
    },
    TasksRoute.name: (routeData) {
      return _i8.CustomPage<dynamic>(
        routeData: routeData,
        child: _i5.TasksPage(),
        maintainState: false,
        transitionsBuilder: _i8.TransitionsBuilders.slideLeft,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProfileRoute.name: (routeData) {
      return _i8.CustomPage<dynamic>(
        routeData: routeData,
        child: _i6.ProfilePage(),
        transitionsBuilder: _i8.TransitionsBuilders.slideTop,
        opaque: true,
        barrierDismissible: false,
      );
    },
    StatisticsRoute.name: (routeData) {
      return _i8.CustomPage<dynamic>(
        routeData: routeData,
        child: _i7.StatisticsPage(),
        transitionsBuilder: _i8.TransitionsBuilders.slideRight,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(
          HomeRouter.name,
          path: '/',
          guards: [authGuard],
          children: [
            _i8.RouteConfig(
              TasksRoute.name,
              path: 'tasks',
              parent: HomeRouter.name,
            ),
            _i8.RouteConfig(
              ProfileRoute.name,
              path: 'profile',
              parent: HomeRouter.name,
            ),
            _i8.RouteConfig(
              StatisticsRoute.name,
              path: 'statistics',
              parent: HomeRouter.name,
            ),
          ],
        ),
        _i8.RouteConfig(
          TaskProfileRoute.name,
          path: '/tasks/:taskId',
          guards: [authGuard],
        ),
        _i8.RouteConfig(
          LoginRoute.name,
          path: '/login',
          guards: [noAuthGuard],
        ),
        _i8.RouteConfig(
          RegisterRoute.name,
          path: '/register',
          guards: [noAuthGuard],
        ),
        _i8.RouteConfig(
          '*#redirect',
          path: '*',
          redirectTo: '/',
          fullMatch: true,
        ),
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRouter extends _i8.PageRouteInfo<void> {
  const HomeRouter({List<_i8.PageRouteInfo>? children})
      : super(
          HomeRouter.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'HomeRouter';
}

/// generated route for
/// [_i2.TaskProfilePage]
class TaskProfileRoute extends _i8.PageRouteInfo<TaskProfileRouteArgs> {
  TaskProfileRoute({String? taskId})
      : super(
          TaskProfileRoute.name,
          path: '/tasks/:taskId',
          args: TaskProfileRouteArgs(taskId: taskId),
          rawPathParams: {'taskId': taskId},
        );

  static const String name = 'TaskProfileRoute';
}

class TaskProfileRouteArgs {
  const TaskProfileRouteArgs({this.taskId});

  final String? taskId;

  @override
  String toString() {
    return 'TaskProfileRouteArgs{taskId: $taskId}';
  }
}

/// generated route for
/// [_i3.LoginPage]
class LoginRoute extends _i8.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i4.RegisterPage]
class RegisterRoute extends _i8.PageRouteInfo<void> {
  const RegisterRoute()
      : super(
          RegisterRoute.name,
          path: '/register',
        );

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i5.TasksPage]
class TasksRoute extends _i8.PageRouteInfo<void> {
  const TasksRoute()
      : super(
          TasksRoute.name,
          path: 'tasks',
        );

  static const String name = 'TasksRoute';
}

/// generated route for
/// [_i6.ProfilePage]
class ProfileRoute extends _i8.PageRouteInfo<void> {
  const ProfileRoute()
      : super(
          ProfileRoute.name,
          path: 'profile',
        );

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [_i7.StatisticsPage]
class StatisticsRoute extends _i8.PageRouteInfo<void> {
  const StatisticsRoute()
      : super(
          StatisticsRoute.name,
          path: 'statistics',
        );

  static const String name = 'StatisticsRoute';
}
