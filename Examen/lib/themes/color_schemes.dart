import 'package:flutter/material.dart';

class AppColorSchemes {
  static const Color greenDark = Color(0xFF2E7D32); // Verde oscuro
  static const Color greenMedium = Color(0xFF4CAF50); // Verde medio
  static const Color greenLight = Color(0xFFC8E6C9); // Verde claro

  // Definimos un esquema de colores con el verde medio como primary y el oscuro como secondary para botones, etc.
  static final ColorScheme lightScheme = ColorScheme.light(
    primary: const Color.fromARGB(255, 53, 94, 55),
    secondary: const Color.fromARGB(255, 52, 156, 147),
  );

  // Degradado para usar en fondos, botones o barras
  static final LinearGradient greenGradient = LinearGradient(
    colors: [
      const Color.fromARGB(255, 48, 205, 168),
      const Color.fromARGB(255, 27, 121, 99),
      const Color.fromARGB(255, 17, 72, 59),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
