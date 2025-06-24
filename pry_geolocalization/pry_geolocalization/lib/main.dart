import 'package:flutter/material.dart';
import 'map_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geolocalización en Tiempo Real',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MapScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
