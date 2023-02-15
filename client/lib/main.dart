import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/routing/guards.dart';
import 'package:flutter_project/routing/router.gr.dart';
import 'package:flutter_project/services/auth.service.dart';
import 'package:flutter_project/config/theme.dart';
import 'config/service_locator.dart';

void main() {
  sl.registerSingleton<AuthService>(AuthService());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final authService = AuthService();

  final _rootRouter =
      RootRouter(authGuard: AuthGuard(), noAuthGuard: NoAuthGuard());

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter TaskManager',
      theme: appTheme,
      routerDelegate: _rootRouter.delegate(
        navigatorObservers: () => [AutoRouteObserver()],
      ),
      routeInformationProvider: _rootRouter.routeInfoProvider(),
      routeInformationParser: _rootRouter.defaultRouteParser(),
      builder: (_, router) {
        return router!;
      },
    );
  }
}
