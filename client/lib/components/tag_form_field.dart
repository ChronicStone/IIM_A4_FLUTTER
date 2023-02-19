import 'package:flutter/material.dart';

typedef OnTagChange = Function(List<String> tags);

class TagFormField extends FormField<List<String>> {
  final OnTagChange? onTagChange;

  TagFormField({
    FormFieldSetter<List<String>>? onSaved,
    required this.onTagChange,
    required FormFieldValidator<List<String>> validator,
    List<String> initialValue = const [],
    AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction,
    InputDecoration decoration = const InputDecoration(
      enabledBorder: UnderlineInputBorder(),
      filled: true,
    ),
  }) : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidateMode: autovalidateMode,
            builder: (FormFieldState<List<String>> state) {
              @override
              void didChange(List<String>? newValue) {
                state.didChange(newValue);
                if (onTagChange != null) {
                  onTagChange!(newValue ?? []);
                }
              }

              final _controller = TextEditingController();
              String _tagInput = '';
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          onChanged: (value) {
                            _tagInput = value;
                          },
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(),
                            filled: true,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (_tagInput.isEmpty == true) return;
                            didChange([...state.value ?? [], _tagInput]);
                            _tagInput = '';
                            _controller.clear();
                          },
                          child: SizedBox(
                              height: 45,
                              child: const Center(child: Icon(Icons.add))))
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Wrap(
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(state.value!.length ?? 0, (index) {
                      String item = (state.value ?? [])[index];
                      return Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Theme.of(state.context)
                                .colorScheme
                                .primary
                                .withOpacity(0.6),
                            border: Border.all(
                                color:
                                    Theme.of(state.context).colorScheme.primary,
                                width: 1.0)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(item),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                didChange(
                                    [...state.value ?? []]..removeAt(index));
                              },
                              child: Icon(Icons.close),
                            ),
                          ],
                        ),
                      );
                    }),
                  )
                ],
              );
            });
}
