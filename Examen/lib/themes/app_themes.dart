import 'package:flutter/material.dart';
import 'color_schemes.dart';
import 'button_styles.dart';
import 'text_style.dart';

final ThemeData appTheme = ThemeData(
  colorScheme: AppColorSchemes.lightScheme,
  elevatedButtonTheme: ElevatedButtonThemeData(style: AppButtonStyles.elevated),
  textTheme: TextTheme(
    headlineMedium: AppTextStyles.titulo,
    bodyMedium: AppTextStyles.aviso,
    bodySmall: AppTextStyles.alerta,
    displayLarge: AppTextStyles.resultado,
  ),
  scaffoldBackgroundColor: const Color.fromARGB(255, 189, 234, 242),
  appBarTheme: AppBarTheme(
    backgroundColor: const Color.fromARGB(255, 67, 116, 122),
    foregroundColor: const Color.fromARGB(255, 255, 255, 255),
    elevation: 4,
  ),
);
