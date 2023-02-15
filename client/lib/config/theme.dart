import 'package:flutter/material.dart';
import 'package:flutter_project/routing/transition.dart';

final appTheme = ThemeData.dark().copyWith(
  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CustomPageTransitionBuilder(),
      TargetPlatform.iOS: CustomPageTransitionBuilder(),
      TargetPlatform.macOS: CustomPageTransitionBuilder(),
      TargetPlatform.windows: CustomPageTransitionBuilder(),
    },
  ),
);
