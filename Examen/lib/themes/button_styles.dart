import 'package:flutter/material.dart';

class AppButtonStyles {
  static final ButtonStyle elevated = ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(255, 90, 77, 38),
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    elevation: 8, // sombra más marcada
    shadowColor: const Color.fromARGB(255, 19, 32, 20), // sombra verde oscura
  );
}
