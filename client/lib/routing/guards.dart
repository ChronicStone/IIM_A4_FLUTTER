import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/routing/router.gr.dart';
import 'package:flutter_project/services/auth.service.dart';
import 'package:get_it/get_it.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    debugPrint(
        'IS AUTH - ${GetIt.instance<AuthService>().isAuthenticated ? 'YES' : 'NO'}');
    if (GetIt.instance<AuthService>().isAuthenticated == false) {
      router.push(const LoginRoute());
    } else {
      resolver.next(true);
    }
  }
}

class NoAuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (GetIt.instance<AuthService>().isAuthenticated == true) {
      router.push(HomeRouter(children: [TasksRoute()]));
    } else {
      resolver.next(true);
    }
  }
}
