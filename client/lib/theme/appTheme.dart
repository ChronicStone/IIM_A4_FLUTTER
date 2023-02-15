import 'package:flutter/material.dart';
import 'package:flutter_project/routing/custom_page_transition.dart';

final appTheme = ThemeData(
  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CustomPageTransitionBuilder(),
      TargetPlatform.iOS: CustomPageTransitionBuilder(),
      TargetPlatform.macOS: CustomPageTransitionBuilder(),
      TargetPlatform.windows: CustomPageTransitionBuilder(),
    },
  ),
);
