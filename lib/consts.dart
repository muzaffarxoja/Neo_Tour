import 'package:flutter/material.dart';

class AppColorSchemes {
  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFFB93C5D),
    primaryContainer: Color(0xFFB93C5D), // Add a primaryContainer color to avoid errors
    onPrimary: Colors.black,
    secondary: Color(0xFFEFF3F3),
    secondaryContainer: Color(0xFFEFF3F3), // Add a secondaryContainer color to avoid errors
    onSecondary: Color(0xFF322942),
    error: Colors.redAccent,
    onError: Colors.white,
    background: Color(0xFFE6EBEB),
    onBackground: Colors.white,
    surface: Color(0xFFFAFBFB),
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFFFF8383),
    primaryContainer: Color(0xFFFF8383), // Add a primaryContainer color to avoid errors
    onPrimary: Colors.white,
    secondary: Color(0xFF4D1F7C),
    secondaryContainer: Color(0xFF4D1F7C), // Add a secondaryContainer color to avoid errors
    onSecondary: Colors.white,
    error: Colors.redAccent,
    onError: Colors.white,
    background: Color(0xFF241E30),
    onBackground: Color(0x0DFFFFFF),
    surface: Color(0xFF1F1929),
    onSurface: Colors.white,
    brightness: Brightness.dark,
  );
}
