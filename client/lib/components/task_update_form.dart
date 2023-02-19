import 'package:flutter/material.dart';
import 'package:flutter_project/components/tag_form_field.dart';
import 'package:flutter_project/utils/validation.dart';
import 'package:flutter_summernote/flutter_summernote.dart';

class TaskUpdateForm extends StatefulWidget {
  TaskUpdateForm({required this.onSubmit, required this.currentProgress});
  final Function({required int progress, String? content}) onSubmit;
  final int currentProgress;
  @override
  _TaskUpdateFormState createState() => _TaskUpdateFormState();
}

class _TaskUpdateFormState extends State<TaskUpdateForm> {
  final _formKey = GlobalKey<FormState>();

  String content = '';
  late double progress = 0;

  @override
  void initState() {
    progress = widget.currentProgress.toDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    'ADD TASK UPDATE',
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
                            const Text(
                              'Description',
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 7,
                              onChanged: (value) {
                                content = value;
                              },
                              decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(),
                                filled: true,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text('Progress',
                                style: TextStyle(fontSize: 16)),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: SliderTheme(
                                      data: SliderThemeData(
                                          trackShape: CustomTrackShape()),
                                      child: Slider(
                                          min: 0,
                                          max: 100,
                                          divisions: 100,
                                          value: progress,
                                          onChanged: (value) {
                                            setState(() {
                                              progress = value;
                                            });
                                          })),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text('${progress.toInt()} %')
                              ],
                            )
                          ])),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    15.0), // Set the border radius to 20.0
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              widget.onSubmit(
                                  content: content, progress: progress.round());
                              Navigator.pop(context);
                            }
                          },
                          child: const SizedBox(
                            height: 50,
                            child: Center(
                                child: Text('UPDATE TASK',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      ],
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
