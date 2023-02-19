import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/components/loading_overlay.dart';
import 'package:flutter_project/routing/guards.dart';
import 'package:flutter_project/routing/router.gr.dart';
import 'package:flutter_project/services/app.service.dart';
import 'package:flutter_project/services/auth.service.dart';
import 'package:flutter_project/config/theme.dart';
import 'package:flutter_project/services/task.service.dart';
import 'package:get_it/get_it.dart';
import 'package:localstorage/localstorage.dart';

Future bootstrapServices() async {
  var storage = new LocalStorage('auth_service');
  await storage.ready;
  var authService = AuthService(storage: storage);
  await authService.initializeAuthState();

  GetIt.instance.registerSingleton<AuthService>(authService);
  GetIt.instance.registerSingleton<TaskService>(TaskService(authService));
  GetIt.instance.registerSingleton<AppService>(AppService());
}

void main() async {
  await bootstrapServices();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
        return LoadingOverlay(
          child: router!,
        );
      },
    );
  }
}
