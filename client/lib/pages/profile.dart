import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_project/components/action_button_stack.dart';
import 'package:flutter_project/routing/router.gr.dart';
import 'package:flutter_project/services/auth.service.dart';
import 'package:get_it/get_it.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var authService = GetIt.instance<AuthService>();

  void signOut() {
    authService.clearSession();
    AutoRouter.of(context).replace(const LoginRoute());
  }

  void handleAction(int index) {
    switch (index) {
      case 0:
        {}
        break;

      case 1:
        {}
        break;

      case 2:
        signOut();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Image.asset(
                      'assets/avatar_default.png',
                      width: 60,
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Text(
                      '${authService.user!.firstName} ${authService.user!.lastName}',
                      style: const TextStyle(
                          fontSize: 21, fontWeight: FontWeight.w700))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.surfaceVariant,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'First name',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              authService.user!.firstName,
                              style: const TextStyle(color: Colors.blueGrey),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          color: Color.fromARGB(41, 255, 255, 255),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Last name',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              authService.user!.lastName,
                              style: const TextStyle(color: Colors.blueGrey),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          color: Color.fromARGB(41, 255, 255, 255),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Email',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              authService.user!.email,
                              style: const TextStyle(color: Colors.blueGrey),
                            )
                          ],
                        ),
                      ],
                    )),
                const SizedBox(height: 25),
                ActionButtonStack(
                  actions: [
                    ActionItem(
                      icon: Icons.logout,
                      label: 'Se déconnecter',
                      iconColor: Colors.red,
                    ),
                  ],
                  onTap: handleAction,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
