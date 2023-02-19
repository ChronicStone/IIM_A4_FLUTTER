import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/components/loading_overlay.dart';
import 'package:flutter_project/components/toast.dart';
import 'package:flutter_project/routing/router.gr.dart';
import 'package:flutter_project/services/auth.service.dart';
import 'package:flutter_project/utils/validation.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  authenticateUser() async {
    var appRouter = AutoRouter.of(context);
    var authService = GetIt.instance<AuthService>();
    var showToast = ToastBuilder(context);
    var loadingOverlay = LoadingOverlay.of(context);

    loadingOverlay.show();
    bool result =
        await authService.authenticate(email: _email, password: _password);
    loadingOverlay.hide();

    if (result == true) {
      String? firstName = authService.user!.firstName;
      String? lastName = authService.user!.lastName;
      showToast(
          type: ToastType.success,
          title: 'Connexion réussie',
          content: 'Bienvenue, $firstName $lastName');

      appRouter.replace(HomeRouter(children: [TasksRoute()]));
    } else {
      showToast(
          type: ToastType.error,
          title: 'Echec de la connexion',
          content: 'L\'adresse email ou le mot de passe sont incorrects');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                RichText(
                  text: TextSpan(
                    text: 'Welcome to ',
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'TrackTaskList',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary)),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'To access the app, please authenticate using your personnal credentials.',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
              ]),
        ),
        Center(
          child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (value) => _email = value,
                      decoration: const InputDecoration(
                          labelText: 'Adresse email',
                          border: OutlineInputBorder()),
                      validator: (value) {
                        return validateEmail(value!);
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (value) => _password = value,
                        decoration: const InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder()),
                        obscureText: true,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'The password field can\'t be empty';
                          }
                          return null;
                        }),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            authenticateUser();
                          }
                        },
                        child: const SizedBox(
                          height: 40.0, // Set the height here
                          child: Center(
                            child: Text('Sign in'),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                        height: 30,
                        width: 150,
                        child: Center(
                          child: Divider(
                            color: Colors.grey,
                            height: 2,
                            thickness: 1,
                          ),
                        )),
                    Center(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 14),
                        ),
                        onPressed: () {
                          AutoRouter.of(context).push(RegisterRoute());
                        },
                        child: const Text('Not registered yet ?'),
                      ),
                    )
                  ],
                ),
              )),
        ),
      ],
    ));
  }
}
