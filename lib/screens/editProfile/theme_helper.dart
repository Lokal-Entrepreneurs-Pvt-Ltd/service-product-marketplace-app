import 'dart:ui';
import 'package:flutter/material.dart';

String _appTheme = "primary";

/// Helper class for managing themes and colors.
class ThemeHelper {
  // A map of custom color themes supported by the app
  Map<String, PrimaryColors> _supportedCustomColor = {
    'primary': PrimaryColors()
  };

// A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'primary': ColorSchemes.primaryColorScheme
  };

  /// Changes the app theme to [_newTheme].
  void changeTheme(String _newTheme) {
    _appTheme = _newTheme;
  }

  /// Returns the primary colors for the current theme.
  PrimaryColors _getThemeColors() {
    //throw exception to notify given theme is not found or not generated by the generator
    if (!_supportedCustomColor.containsKey(_appTheme)) {
      throw Exception(
          "$_appTheme is not found.Make sure you have added this theme class in JSON Try running flutter pub run build_runner");
    }
    //return theme from map

    return _supportedCustomColor[_appTheme] ?? PrimaryColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    //throw exception to notify given theme is not found or not generated by the generator
    if (!_supportedColorScheme.containsKey(_appTheme)) {
      throw Exception(
          "$_appTheme is not found.Make sure you have added this theme class in JSON Try running flutter pub run build_runner");
    }
    //return theme from map

    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.primaryColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      scaffoldBackgroundColor: colorScheme.onPrimaryContainer.withOpacity(1),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: 1,
        space: 1,
        color: appTheme.gray200,
      ),
    );
  }

  /// Returns the primary colors for the current theme.
  PrimaryColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

/// Class containing the supported text theme styles.
class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyLarge: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 16,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          color: appTheme.gray500,
          fontSize: 14,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
        labelLarge: TextStyle(
          color: appTheme.yellowA700,
          fontSize: 12,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
        titleMedium: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 16,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
      );
}

/// Class containing the supported color schemes.
class ColorSchemes {
  static final primaryColorScheme = ColorScheme.light(
    // Primary colors
    primary: Color(0XFFFEE440),
    primaryContainer: Color(0XFF5151C6),
    secondary: Color(0XFF5151C6),
    secondaryContainer: Color(0XE5FFFFFF),
    tertiary: Color(0XFF5151C6),
    tertiaryContainer: Color(0XE5FFFFFF),

    // Background colors
    background: Color(0XFF5151C6),

    // Surface colors
    surface: Color(0XFF5151C6),
    surfaceTint: Color(0XFF212121),
    surfaceVariant: Color(0XE5FFFFFF),

    // Error colors
    error: Color(0XFF212121),
    errorContainer: Color(0XFF888BF4),
    onError: Color(0XFFBDBDBD),
    onErrorContainer: Color(0XFF212121),

    // On colors(text colors)
    onBackground: Color(0XE5FFFFFF),
    onInverseSurface: Color(0XFFBDBDBD),
    onPrimary: Color(0XFF212121),
    onPrimaryContainer: Color(0XE5FFFFFF),
    onSecondary: Color(0XE5FFFFFF),
    onSecondaryContainer: Color(0XFF212121),
    onTertiary: Color(0XE5FFFFFF),
    onTertiaryContainer: Color(0XFF212121),

    // Other colors
    outline: Color(0XFF212121),
    outlineVariant: Color(0XFF5151C6),
    scrim: Color(0XFF5151C6),
    shadow: Color(0XFF212121),

    // Inverse colors
    inversePrimary: Color(0XFF5151C6),
    inverseSurface: Color(0XFF212121),

    // Pending colors
    onSurface: Color(0XE5FFFFFF),
    onSurfaceVariant: Color(0XFF212121),
  );
}

/// Class containing custom colors for a primary theme.
class PrimaryColors {
  // Black
  Color get black900 => Color(0XFF000000);

  // BlueGray
  Color get blueGray400 => Color(0XFF888888);

  // Gray
  Color get gray100 => Color(0XFFF5F5F5);
  Color get gray200 => Color(0XFFEEEEEE);
  Color get gray20001 => Color(0XFFECEDEE);
  Color get gray500 => Color(0XFF9E9E9E);

  // Indigo
  Color get indigo400 => Color(0XFF5959CC);

  // Yellow
  Color get yellowA700 => Color(0XFFFFD60A);
}

PrimaryColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();
