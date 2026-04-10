extension StringExtension on String {
  bool get isEmail => RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(this);

  bool get isPhone => RegExp(r'^[0-9]{9,15}$').hasMatch(this);

  bool get isValidUuid {
    final regex = RegExp(
      '^[0-9a-fA-F]{8}-'
      '[0-9a-fA-F]{4}-'
      '[0-9a-fA-F]{4}-'
      '[0-9a-fA-F]{4}-'
      r'[0-9a-fA-F]{12}$',
    );
    return regex.hasMatch(this);
  }
}
