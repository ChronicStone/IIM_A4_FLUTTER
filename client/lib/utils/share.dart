import 'package:flutter/material.dart';
import 'package:flutter_project/components/toast.dart';
import 'package:url_launcher/url_launcher.dart';

void launchEmailApp(BuildContext context,
    {required String emailAddress,
    required String subject,
    required String body}) async {
  var notifier = ToastBuilder(context);
  final Uri params = Uri(
    scheme: 'mailto',
    path: emailAddress,
    query: 'subject=$subject&body=$body',
  );

  if (await canLaunchUrl(params)) {
    await launchUrl(params);
  } else {
    notifier(
        type: ToastType.error,
        title: 'Error',
        content: 'No email client available on your device');
  }
}
