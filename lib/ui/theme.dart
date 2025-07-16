import 'package:flutter/material.dart';

const Color _primaryColor = Color(0xFF6B6969);
const Color _secondaryColor = Color(0xFFCDCDCD);
const Color _tertiaryColor = Color(0xFF424242);
const Color _backgroundColor = Color(0xFFF0F0F0);

final ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: _primaryColor,
    primary: _primaryColor,
    secondary: _secondaryColor,
    tertiary: _tertiaryColor,
    background: _backgroundColor,
    surface: _backgroundColor,
  ),
  
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    foregroundColor: Colors.black87,
    centerTitle: true,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _primaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: _primaryColor, width: 2),
    ),
    labelStyle: const TextStyle(color: _tertiaryColor),
  ),

  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: _primaryColor,
    foregroundColor: Colors.white,
  ),

  useMaterial3: true,
);

const BoxDecoration appBackgroundDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [Color(0xFFCDCDCD), Color(0xFFC4C4C4)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
);