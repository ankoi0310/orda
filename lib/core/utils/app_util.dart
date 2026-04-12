import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme createTextTheme(
  BuildContext context,
  String bodyFontString,
  String displayFontString,
) {
  final baseTextTheme = Theme.of(context).textTheme;
  final bodyTextTheme = GoogleFonts.getTextTheme(
    bodyFontString,
    baseTextTheme,
  );
  final displayTextTheme = GoogleFonts.getTextTheme(
    displayFontString,
    baseTextTheme,
  );
  final textTheme = displayTextTheme.copyWith(
    headlineLarge: displayTextTheme.headlineLarge!.copyWith(
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: displayTextTheme.headlineMedium,
    headlineSmall: bodyTextTheme.headlineSmall,
    titleLarge: displayTextTheme.titleLarge!.copyWith(
      fontWeight: FontWeight.bold,
    ),
    titleMedium: bodyTextTheme.titleMedium!.copyWith(
      fontWeight: FontWeight.normal,
    ),
    titleSmall: bodyTextTheme.titleSmall!.copyWith(
      fontWeight: FontWeight.w200,
    ),
    bodyLarge: displayTextTheme.bodyLarge!.copyWith(
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge!.copyWith(
      fontWeight: FontWeight.bold,
    ),
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
  );
  return textTheme;
}

void showSnackBar(BuildContext context, {required String content}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(content)));
}
