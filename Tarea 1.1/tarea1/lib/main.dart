import 'package:flutter/material.dart';
import 'menu/menu.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Mi App',
      home: MenuPrincipal(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MyApp extends MaterialApp{
  const MyApp(
    {super.key}
  );
}

