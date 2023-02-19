import 'package:flutter/material.dart';
import 'package:flutter_project/components/tag_form_field.dart';
import 'package:flutter_project/utils/validation.dart';
import 'package:flutter_summernote/flutter_summernote.dart';

class TaskForm extends StatefulWidget {
  TaskForm({required this.onSubmit});
  final Function(
      {required String title,
      String? description,
      List<String>? tags}) onSubmit;
  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  final _keyEditor = GlobalKey<FlutterSummernoteState>();

  String title = '';
  String description = '';
  List<String> tags = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                        child: Text(
                      'CREATE NEW TASK',
                      style: Theme.of(context).textTheme.headlineSmall,
                    )),
                    const SizedBox(
                      height: 15,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 15,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text.rich(
                              TextSpan(
                                children: <InlineSpan>[
                                  WidgetSpan(
                                    child: Text(
                                      'Title ',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: Text(
                                      '*',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                return validateRequiredField('title', value!);
                              },
                              onChanged: (value) {
                                title = value;
                              },
                              decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(),
                                filled: true,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Description',
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                onChanged: (value) {
                                  description = value;
                                },
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(),
                                  filled: true,
                                ),
                                keyboardType: TextInputType.multiline,
                                maxLines: 7),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Tags',
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TagFormField(
                                onTagChange: (value) {
                                  tags = value ?? [];
                                },
                                validator: (value) {})
                          ],
                        ))
                  ]),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: 75.0, // Height of the bottom row
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              15.0), // Set the border radius to 20.0
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.onSubmit(
                            description: description, title: title, tags: tags);
                        Navigator.pop(context);
                      }
                    },
                    child: const SizedBox(
                      height: 50,
                      child: Center(
                          child: Text('CREATE TASK',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
