import 'package:flutter/material.dart';
import '../../domain/entities/order.dart';
import '../../domain/entities/order_detail.dart';
import '../../application/usecases/order_usecase.dart';
import '../../application/usecases/order_detail_usecase.dart';

class OrdersScreen extends StatefulWidget {
  final OrderUsecase orderUsecase;
  final OrderDetailUsecase orderDetailUsecase;

  OrdersScreen({required this.orderUsecase, required this.orderDetailUsecase});

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late Future<List<Order>> orders;

  @override
  void initState() {
    super.initState();
    orders = widget.orderUsecase.fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pedidos")),
      body: FutureBuilder<List<Order>>(
        future: orders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final ordersList = snapshot.data!;
            return ListView.builder(
              itemCount: ordersList.length,
              itemBuilder: (context, index) {
                final order = ordersList[index];
                return ListTile(
                  title: Text(order.clientName),
                  subtitle: Text(order.date.toLocal().toString()),
                  onTap: () => _showOrderDetails(context, order),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _createOrder(context),
      ),
    );
  }

  void _createOrder(BuildContext context) async {
    final newOrder = await widget.orderUsecase.create(
      Order(id: 0, clientName: "Nuevo Cliente", date: DateTime.now()),
    );
    setState(() {
      orders = widget.orderUsecase.fetchAll();
    });
  }

  void _showOrderDetails(BuildContext context, Order order) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => OrderDetailsScreen(
              order: order,
              orderDetailUsecase: widget.orderDetailUsecase,
            ),
      ),
    );
  }
}

class OrderDetailsScreen extends StatelessWidget {
  final Order order;
  final OrderDetailUsecase orderDetailUsecase;

  OrderDetailsScreen({required this.order, required this.orderDetailUsecase});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalles del Pedido")),
      body: Center(
        child: ElevatedButton(
          child: Text("Añadir Detalle"),
          onPressed: () async {
            await orderDetailUsecase.create(
              order.id,
              OrderDetail(
                id: 0,
                orderId: order.id,
                product: "Producto X",
                amount: 1,
                unitPrice: 10.0,
              ),
            );
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Detalle añadido')));
          },
        ),
      ),
    );
  }
}
