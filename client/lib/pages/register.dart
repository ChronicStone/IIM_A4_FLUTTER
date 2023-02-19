import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/components/loading_overlay.dart';
import 'package:flutter_project/components/toast.dart';
import 'package:flutter_project/routing/router.gr.dart';
import 'package:flutter_project/services/auth.service.dart';
import 'package:flutter_project/utils/validation.dart';
import 'package:get_it/get_it.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  bool _passwordVisibility = false;

  String _email = '';
  String _firstName = '';
  String _lastName = '';
  String _password = '';
  String _confirmPassword = '';

  Future registerUser() async {
    var appRouter = AutoRouter.of(context);
    var showToast = ToastBuilder(context);
    var overlay = LoadingOverlay.of(context);
    overlay.show();
    bool result = await GetIt.instance<AuthService>().registerUser(
        firstName: _firstName,
        lastName: _lastName,
        email: _email,
        password: _password);
    overlay.hide();

    if (result == true) {
      showToast(
          type: ToastType.success,
          title: 'Inscription réussie',
          content: 'Vous pouvez maintenant vous connecter');

      appRouter.push(const LoginRoute());
    } else {
      showToast(
          type: ToastType.error,
          title: 'Echec de l\'inscription',
          content: 'Adresse email non disponnible');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                    'To access the app, please complete the following registration form.',
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
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  onChanged: (value) => _firstName = value,
                                  validator: (value) {
                                    return validateRequiredField(
                                        'first name', value!);
                                  },
                                  decoration: const InputDecoration(
                                      hintText: 'John',
                                      labelText: 'First name',
                                      border: OutlineInputBorder()),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  onChanged: (value) => _lastName = value,
                                  validator: (value) {
                                    return validateRequiredField(
                                        'last name', value!);
                                  },
                                  decoration: const InputDecoration(
                                      hintText: 'DOE',
                                      labelText: 'Last name',
                                      border: OutlineInputBorder()),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onChanged: (value) => _email = value,
                            validator: (value) {
                              return validateEmail(value!);
                            },
                            decoration: const InputDecoration(
                                hintText: 'john.doe@email.com',
                                labelText: 'Email address',
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onChanged: (value) => _password = value,
                            validator: (value) {
                              return validatePassword(value!);
                            },
                            obscureText: !_passwordVisibility,
                            decoration: InputDecoration(
                              hintText: '************',
                              labelText: 'Password',
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVisibility
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisibility = !_passwordVisibility;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onChanged: (value) => _confirmPassword = value,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password confirmation can\'t be empty';
                              }

                              if (value == _password) {
                                return null;
                              } else {
                                return 'The password & the confirmation are not matching';
                              }
                            },
                            obscureText: !_passwordVisibility,
                            decoration: InputDecoration(
                              hintText: '************',
                              labelText: 'Confirm password',
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVisibility
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisibility = !_passwordVisibility;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  registerUser();
                                }
                              },
                              child: const SizedBox(
                                height: 40.0,
                                child: Center(
                                  child: Text('Sign up'),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
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
                                AutoRouter.of(context).pop();
                              },
                              child: const Text('Already registered ? Sign in'),
                            ),
                          )
                        ]))),
          ),
        ],
      ),
    );
  }
}
