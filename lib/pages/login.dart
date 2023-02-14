import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connectez-vous'),
      ),
      body: Center(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    onChanged: (value) => _email = value,
                    decoration: const InputDecoration(
                        labelText: 'Email', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                      onChanged: (value) => _password = value,
                      decoration: const InputDecoration(
                          labelText: 'Password', border: OutlineInputBorder()),
                      obscureText: true),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Add button action
                      },
                      child: const SizedBox(
                        height: 40.0, // Set the height here
                        child: Center(
                          child: Text('Se connecter'),
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
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text('Pas encore inscrit ?'),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
