import 'package:flutter/material.dart';
import 'application/usecases/order_usecase.dart';
import 'application/usecases/order_detail_usecase.dart';
import 'data/datasources/order_api.dart';
import 'data/repositories/order_repository_impl.dart';
import 'data/repositories/order_detail_repository_impl.dart';
import 'presentation/screens/orders_screen.dart';

void main() {
  final orderApi = OrderApi();
  final orderRepository = OrderRepositoryImpl(orderApi);
  final orderDetailRepository = OrderDetailRepositoryImpl(orderApi);

  final orderUsecase = OrderUsecase(orderRepository);
  final orderDetailUsecase = OrderDetailUsecase(orderDetailRepository);

  runApp(MyApp(orderUsecase, orderDetailUsecase));
}

class MyApp extends StatelessWidget {
  final OrderUsecase orderUsecase;
  final OrderDetailUsecase orderDetailUsecase;

  MyApp(this.orderUsecase, this.orderDetailUsecase);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OrdersScreen(
        orderUsecase: orderUsecase,
        orderDetailUsecase: orderDetailUsecase,
      ),
    );
  }
}
