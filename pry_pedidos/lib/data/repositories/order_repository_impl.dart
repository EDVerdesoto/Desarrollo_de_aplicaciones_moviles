import '../../domain/entities/order.dart';

import '../datasources/order_api.dart';

class OrderRepositoryImpl {
  final OrderApi api;
  OrderRepositoryImpl(this.api);

  Future<List<Order>> getContacts() => api.fetchOrders();
  Future<Order> create(Order order) => api.createOrder(order);
  Future<Order> getOrder(int orderId) => api.getOrder(orderId);
}