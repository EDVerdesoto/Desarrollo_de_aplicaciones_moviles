import 'package:flutter/material.dart';
import '../controllers/anio_controller.dart';
import '../themes/text_style.dart';
import '../themes/button_styles.dart';

class VerificarView extends StatelessWidget {
  // Controllers para inputs
  final TextEditingController _anioC = TextEditingController();
  final TextEditingController _cantidadC = TextEditingController();

  final AnioController controller = AnioController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verificar el año bisiesto',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _anioC,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Ingrese un año",
                labelStyle: AppTextStyles.aviso,
                border: OutlineInputBorder(),
              ),
              style: AppTextStyles.aviso,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _cantidadC,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Ingrese una cantidad",
                labelStyle: AppTextStyles.aviso,
                border: OutlineInputBorder(),
              ),
              style: AppTextStyles.aviso,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              style: AppButtonStyles.elevated,
              onPressed: () {
                final anioText = _anioC.text.trim();
                final cantidadText = _cantidadC.text.trim();

                int? anio = int.tryParse(anioText);
                int? cantidad = int.tryParse(cantidadText);

                if (anio == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Año no válido',
                        style: AppTextStyles.alerta,
                      ),
                      backgroundColor: Colors.black87,
                    ),
                  );
                  return;
                }
                if (cantidad == null || cantidad <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Cantidad no válida',
                        style: AppTextStyles.alerta,
                      ),
                      backgroundColor: Colors.black87,
                    ),
                  );
                  return;
                }

                final esBisiesto = controller.verificarBisiesto(anio);
                if (!esBisiesto && cantidad == 1) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'El año $anio NO es bisiesto',
                        style: AppTextStyles.alerta,
                      ),
                      backgroundColor: Colors.black87,
                    ),
                  );
                  return;
                }

                // Navegar a resultados pasando argumentos
                Navigator.pushNamed(
                  context,
                  '/resultado',
                  arguments: {'anio': anio, 'cantidad': cantidad},
                );
              },
              child: Text(
                'Verificar',
                style: AppTextStyles.titulo.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
