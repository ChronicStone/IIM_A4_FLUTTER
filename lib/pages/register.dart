import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _firstName = '';
  String _lastName = '';

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
                        children: const [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: 'John',
                                  labelText: 'Prénom',
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          SizedBox(
                              width: 10), // add some spacing between the fields
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: 'DOE',
                                  labelText: 'Nom de famille',
                                  border: OutlineInputBorder()),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const TextField(
                        decoration: InputDecoration(
                            hintText: 'john.doe@email.com',
                            labelText: 'Adresse email',
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: const [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: '************',
                                  labelText: 'Mot de passe',
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          SizedBox(
                              width: 10), // add some spacing between the fields
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: '************',
                                  labelText: 'Confirmez mot de passe',
                                  border: OutlineInputBorder()),
                            ),
                          ),
                        ],
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
