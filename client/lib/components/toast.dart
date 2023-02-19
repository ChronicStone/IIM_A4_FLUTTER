import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastType { success, error }

Function(
    {ToastGravity placement,
    required ToastType type,
    String? title,
    required String content,
    int duration}) ToastBuilder(context) {
  FToast ftoast = FToast();
  var toastController = ftoast.init(context);

  return (
      {ToastGravity placement = ToastGravity.TOP,
      required ToastType type,
      String? title,
      required String content,
      int duration = 3}) {
    toastController.showToast(
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: duration),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          child: Card(
              color: Theme.of(context).splashColor,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(), //<-- SEE HERE
                        padding: const EdgeInsets.all(10),
                        backgroundColor: type == ToastType.error
                            ? Colors.red
                            : Colors.lightGreen,
                      ),
                      child: Icon(
                        //<-- SEE HERE
                        type == ToastType.error ? Icons.close : Icons.check,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (title!.isEmpty == false)
                            Text(title,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800)),
                          if (title!.isEmpty == false)
                            const SizedBox(height: 4),
                          Text(
                            content,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  };
}
