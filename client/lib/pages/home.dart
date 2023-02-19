import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_project/routing/router.gr.dart';
import 'package:flutter_project/services/auth.service.dart';
import 'package:get_it/get_it.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var authService = GetIt.instance<AuthService>();
  void signOut() {
    authService.clearSession();
    AutoRouter.of(context).replace(const LoginRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: AutoTabsScaffold(
            routes: const [TasksRoute(), ProfileRoute()],
            bottomNavigationBuilder: (_, tabsRouter) {
              return Container(
                color: Theme.of(context).colorScheme.surfaceVariant,
                child: SalomonBottomBar(
                  currentIndex: tabsRouter.activeIndex,
                  onTap: tabsRouter.setActiveIndex,
                  items: [
                    SalomonBottomBarItem(
                      icon: Icon(Icons.topic),
                      title: Text("Tasks"),
                      selectedColor: Theme.of(context).colorScheme.primary,
                    ),
                    SalomonBottomBarItem(
                      icon: Icon(Icons.person),
                      title: Text("Profile"),
                      selectedColor: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              );
            }),
        body: AutoRouter());
  }
}
