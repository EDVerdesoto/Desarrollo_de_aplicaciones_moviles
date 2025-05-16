import 'package:flutter/material.dart';
import 'package:pry_anio_bisiesto/themes/button_styles.dart';
import '../controllers/anio_controller.dart';
import '../themes/contenedor_layouts.dart';
import '../themes/text_style.dart';

class ResultadoView extends StatelessWidget {
  final controller = AnioController();

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final anio = args?['anio'] ?? 2024;
    final cantidad = args?['cantidad'] ?? 10;

    final lista = controller.obtenerUltimos(anio, cantidad);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lista de años bisiestos",
          style:
              Theme.of(
                context,
              ).appBarTheme.titleTextStyle, // usa estilo del tema
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: lista.length,
                itemBuilder: (context, index) {
                  final anio = lista[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: AppContainerDecorations.card,
                    child: ListTile(
                      title: Text(
                        'Año $anio',
                        style:
                            AppTextStyles
                                .resultado, // Usa estilo de resultado (grande y redondeado)
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: AppButtonStyles.elevated,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Volver",
                style: AppTextStyles.titulo.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
