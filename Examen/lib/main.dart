import 'package:bandido_financiero/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'view/home_screen.dart';
import 'themes/app_themes.dart';

void main() {
  runApp(ProviderScope(child: BandidoFinancieroApp()));
}

class BandidoFinancieroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bandido Financiero',
      theme: appTheme,
      home: HomeScreen(),
    );
  }
}
