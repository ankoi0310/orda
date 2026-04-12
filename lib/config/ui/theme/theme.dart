import 'package:flutter/material.dart';

class MaterialTheme {
  const MaterialTheme(this.textTheme);

  final TextTheme textTheme;

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff171717),
      surfaceTint: Colors.transparent,
      onPrimary: Color(0xfffafafa),
      primaryContainer: Color(0xfff5f5f5),
      onPrimaryContainer: Color(0xff737373),
      secondary: Color(0xfff5f5f5),
      onSecondary: Color(0xff171717),
      tertiary: Color(0xfff5f5f5),
      onTertiary: Color(0xff171717),
      error: Color(0xffe7000b),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xffffffff),
      onSurface: Color(0xff0a0a0a),
      onSurfaceVariant: Color(0xff424242),
      outline: Color(0xffe5e5e5),
      outlineVariant: Color(0xffbcbcbc),
      shadow: Color(0xff000000),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffe5e5e5),
      surfaceTint: Colors.transparent,
      onPrimary: Color(0xff171717),
      primaryContainer: Color(0xff737373),
      onPrimaryContainer: Color(0xfff5f5f5),
      secondary: Color(0xff262626),
      onSecondary: Color(0xfffafafa),
      tertiary: Color(0xff262626),
      onTertiary: Color(0xfffafafa),
      error: Color(0xffff6467),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0a0a0a),
      onSurface: Color(0xfffafafa),
      onSurfaceVariant: Color(0xffc1c9bf),
      outline: Color(0x1affffff),
      outlineVariant: Color(0x1abfbfbf),
      shadow: Color(0xffffffff),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  OutlineInputBorder _border({
    required Color color,
    double? borderWidth,
  }) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: borderWidth ?? 1),
      borderRadius: BorderRadius.circular(12),
    );
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    splashColor: Colors.transparent,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
    appBarTheme: AppBarTheme(
      titleTextStyle: textTheme.titleLarge,
      titleSpacing: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: _border(color: colorScheme.onPrimaryContainer),
      enabledBorder: _border(color: colorScheme.onPrimaryContainer),
      focusedBorder: _border(
        color: colorScheme.onPrimaryContainer,
        borderWidth: 2,
      ),
      errorBorder: _border(color: colorScheme.onErrorContainer),
      focusedErrorBorder: _border(
        color: colorScheme.onErrorContainer,
        borderWidth: 2,
      ),
      iconColor: colorScheme.primary,
      prefixIconColor: colorScheme.primary,
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(8),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8),
          ),
        ),
        padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
          EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 12),
        ),
        backgroundColor: WidgetStatePropertyAll(colorScheme.primary),
        foregroundColor: WidgetStatePropertyAll(
          colorScheme.onPrimary,
        ),
        textStyle: WidgetStatePropertyAll(
          textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8),
          ),
        ),
        padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
          EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 12),
        ),
        foregroundColor: WidgetStatePropertyAll(
          colorScheme.onPrimary,
        ),
        textStyle: WidgetStatePropertyAll(
          textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      showUnselectedLabels: false,
      showSelectedLabels: false,
      type: BottomNavigationBarType.fixed,
    ),
  );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });

  final Color seed;
  final Color value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
