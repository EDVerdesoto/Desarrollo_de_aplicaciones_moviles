import '../../domain/entities/order_detail.dart';
import '../../data/repositories/order_detail_repository_impl.dart';

class OrderDetailUsecase {
  final OrderDetailRepositoryImpl repositoryImpl;
  
  OrderDetailUsecase(this.repositoryImpl);

  Future<OrderDetail> create(int orderId, OrderDetail orderDetail) => repositoryImpl.createOrderDetail(orderId, orderDetail);
}