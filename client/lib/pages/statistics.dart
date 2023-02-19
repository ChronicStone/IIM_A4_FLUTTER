import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_project/routing/router.gr.dart';
import 'package:flutter_project/services/auth.service.dart';
import 'package:get_it/get_it.dart';

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  var authService = GetIt.instance<AuthService>();

  void signOut() {
    authService.clearSession();
    AutoRouter.of(context).replace(const LoginRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Stats'),
        ),
        body: Center(
          child: Column(
            children: [
              Text(
                  'Welcome, ${authService.user!.firstName} ${authService.user!.lastName}'),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: signOut,
                  child: const SizedBox(
                    height: 30,
                    child: Text('Déconnexion'),
                  ))
            ],
          ),
        ));
  }
}
