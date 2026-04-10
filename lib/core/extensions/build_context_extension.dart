import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  /// Theme
  ThemeData get theme => Theme.of(this);

  /// Text Theme
  TextTheme get textTheme => theme.textTheme;

  /// Color Scheme
  ColorScheme get colors => theme.colorScheme;

  /// MediaQuery
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Screen size
  Size get screenSize => mediaQuery.size;

  double get width => screenSize.width;
  double get height => screenSize.height;

  /// Padding
  EdgeInsets get padding => mediaQuery.padding;

  /// ViewInsets (keyboard)
  EdgeInsets get viewInsets => mediaQuery.viewInsets;
}
