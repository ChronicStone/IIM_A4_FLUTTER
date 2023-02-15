import 'package:auto_route/auto_route.dart';
import 'package:flutter_project/pages/home/home.dart';
import 'package:flutter_project/pages/login.dart';
import 'package:flutter_project/pages/register.dart';
import 'package:flutter_project/pages/task_lists.dart';
import 'package:flutter_project/routing/guards.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page|Screen,Route',
  routes: <AutoRoute>[
    // app stack
    AutoRoute<String>(
      path: '/',
      page: HomePage,
      guards: [AuthGuard],
    ),
    AutoRoute(page: LoginPage, path: '/login', guards: [NoAuthGuard]),
    AutoRoute(page: RegisterPage, path: '/register', guards: [NoAuthGuard]),
    RedirectRoute(path: '*', redirectTo: '/'),
  ],
)
class $RootRouter {}
