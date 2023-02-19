import 'package:flutter/material.dart';
import 'package:flutter_project/routing/transition.dart';
import 'package:google_fonts/google_fonts.dart';

final appTheme = ThemeData.dark().copyWith(
  colorScheme: const ColorScheme.dark().copyWith(
    primary: const Color.fromARGB(255, 110, 194, 177),
    surfaceVariant: const Color.fromARGB(255, 42, 43, 45),
  ),
  textTheme: GoogleFonts.latoTextTheme(ThemeData.dark().textTheme),
  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CustomPageTransitionBuilder(),
      TargetPlatform.iOS: CustomPageTransitionBuilder(),
      TargetPlatform.macOS: CustomPageTransitionBuilder(),
      TargetPlatform.windows: CustomPageTransitionBuilder(),
    },
  ),
);
