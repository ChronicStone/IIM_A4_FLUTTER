import 'package:flutter/material.dart';
import 'package:flutter_project/routing/route_observer.dart';
import 'package:flutter_project/routing/routes.dart';
import 'package:flutter_project/services/auth.service.dart';
import 'package:flutter_project/theme/appTheme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: appRoutes,
      navigatorObservers: [routeObserver],
      theme: appTheme,
    );
  }
}
