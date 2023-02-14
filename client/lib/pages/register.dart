import 'package:flutter/material.dart';
import 'package:flutter_project/utils/validation.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enregistrez-vous'),
      ),
      body: Center(
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
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              onChanged: (value) => _firstName = value,
                              validator: (value) {
                                return validateRequiredField('prénom', value!);
                              },
                              decoration: const InputDecoration(
                                  hintText: 'John',
                                  labelText: 'Prénom',
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          const SizedBox(
                              width: 10),
                          Expanded(
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              onChanged: (value) => _lastName = value,
                              validator: (value) {
                                return validateRequiredField('prénom', value!);
                              },
                              decoration: const InputDecoration(
                                  hintText: 'DOE',
                                  labelText: 'Nom de famille',
                                  border: OutlineInputBorder()),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (value) => _email = value,
                        validator: (value) {
                          return validateEmail(value!);
                        },
                        decoration: const InputDecoration(
                            hintText: 'john.doe@email.com',
                            labelText: 'Adresse email',
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (value) => _password = value,
                        validator: (value) {
                          return validatePassword(value!);
                        },
                        obscureText: !_passwordVisibility,
                        decoration: InputDecoration(
                          hintText: '************',
                          labelText: 'Mot de passe',
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (value) => _confirmPassword = value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'La confirmation du mot de passe est requise';
                          }

                          if (value == _password) {
                            return null;
                          }

                          else {
                            return 'Le mot de passe et la confirmation de correspondent pas';
                          }

                        },
                        obscureText: !_passwordVisibility,
                        decoration: InputDecoration(
                          hintText: '************',
                          labelText: 'Confirmez  mot de passe',
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
                            if (_formKey.currentState!.validate()) {}
                          },
                          child: const SizedBox(
                            height: 40.0,
                            child: Center(
                              child: Text('S\'enregistrer'),
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
                            Navigator.of(context).pop();
                          },
                          child: const Text('Déjà inscrit ? Connectez vous'),
                        ),
                      )
                    ]))),
      ),
    );
  }
}
