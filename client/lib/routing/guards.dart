import 'package:auto_route/auto_route.dart';
import 'package:flutter_project/config/service_locator.dart';
import 'package:flutter_project/routing/router.gr.dart';
import 'package:flutter_project/services/auth.service.dart';

class AuthGuard extends AutoRouteGuard {
  var authService = sl.get<AuthService>();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (!authService.isAuthenticated) {
      // ignore: unawaited_futures
      router.push(const LoginRoute());
    } else {
      resolver.next(true);
    }
  }
}

class NoAuthGuard extends AutoRouteGuard {
  var authService = sl.get<AuthService>();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (authService.isAuthenticated) {
      // ignore: unawaited_futures
      router.push(const TasksListRoute());
    } else {
      resolver.next(true);
    }
  }
}
