import '../../domain/entities/order_detail.dart';

import '../datasources/order_api.dart';

class OrderDetailRepositoryImpl {
  final OrderApi api;
  OrderDetailRepositoryImpl(this.api);

  Future<OrderDetail> createOrderDetail(int orderId, OrderDetail orderDetail) => api.createOrderDetail(orderId, orderDetail);
}