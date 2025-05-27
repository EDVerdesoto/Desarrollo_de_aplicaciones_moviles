import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cliente_providers.dart';
import '../services/calculadora_servicio.dart';
import 'details_screen.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultados = ref.watch(resultadosProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Bandido Financiero')),
      body:
          resultados.isEmpty
              ? Center(child: Text('No hay datos de clientes'))
              : ListView.builder(
                itemCount: resultados.length,
                itemBuilder: (_, i) {
                  return ClienteCard(resultado: resultados[i]);
                },
              ),
    );
  }
}

class ClienteCard extends StatefulWidget {
  final ResultadoCliente resultado;
  ClienteCard({required this.resultado});

  @override
  _ClienteCardState createState() => _ClienteCardState();
}

class _ClienteCardState extends State<ClienteCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _animBar;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    _animBar = Tween<double>(
      begin: 0,
      end: widget.resultado.pagoMinimo,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.resultado.cliente.id,
      flightShuttleBuilder: (
        flightContext,
        animation,
        flightDirection,
        fromHeroContext,
        toHeroContext,
      ) {
        return ScaleTransition(
          scale: animation.drive(
            Tween(
              begin: 0.5,
              end: 1.0,
            ).chain(CurveTween(curve: Curves.easeInOut)),
          ),
          child: Material(
            type: MaterialType.transparency,
            child:
                flightDirection == HeroFlightDirection.push
                    ? fromHeroContext.widget
                    : toHeroContext.widget,
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.resultado.cliente.nombre,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color:
                      widget.resultado.saldoActual >= 0
                          ? Colors.green[50]
                          : Colors.red[50],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Saldo: \$${widget.resultado.saldoActual.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 8),
              AnimatedBuilder(
                animation: _animBar,
                builder:
                    (_, __) => Container(
                      width: double.infinity,
                      height: 10,
                      color: Colors.grey[300],
                      child: FractionallySizedBox(
                        widthFactor:
                            widget.resultado.saldoActual > 0
                                ? _animBar.value / widget.resultado.saldoActual
                                : 0,
                        alignment: Alignment.centerLeft,
                        child: Container(color: Colors.blue),
                      ),
                    ),
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 500),
                        pageBuilder:
                            (_, anim, __) =>
                                DetalleScreen(resultado: widget.resultado),
                        transitionsBuilder: (_, animation, __, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: ScaleTransition(
                              scale: Tween(begin: 0.9, end: 1.0).animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeOut,
                                ),
                              ),
                              child: child,
                            ),
                          );
                        },
                      ),
                    );
                  },
                  child: Text('Ver detalle'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
