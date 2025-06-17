import '../../domain/entities/order.dart';
import '../../data/repositories/order_repository_impl.dart';

class OrderUsecase {
  final OrderRepositoryImpl repositoryImpl;
  
  OrderUsecase(this.repositoryImpl);

  Future<List<Order>> fetchAll() => repositoryImpl.getContacts();
  Future<Order> create(Order order) => repositoryImpl.create(order);
  Future<Order> getById(int orderId) => repositoryImpl.getOrder(orderId);
}