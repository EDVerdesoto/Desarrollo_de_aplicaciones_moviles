import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pry_pedidos/domain/entities/order_detail.dart';
import '../../domain/entities/order.dart';

class OrderApi {
  final String baseUrl = 'http://localhost:8081/api/orders';

  Future<List<Order>> fetchOrders() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Order.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar pedidos');
    }
  }

  Future<Order> getOrder(int orderId) async {
    final response = await http.get(Uri.parse('$baseUrl/$orderId'));

    if (response.statusCode == 200) {
      return Order.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al cargar pedido');
    }
  }

  Future<Order> createOrder(Order order) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(order.toJson()..remove('id')),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Order.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al crear pedido');
    }
  }

  Future<OrderDetail> createOrderDetail(
    int orderId,
    OrderDetail orderDetail,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$orderId/details'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(orderDetail.toJson()..remove('id')),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return OrderDetail.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al crear detalle del pedido $orderId');
    }
  }
}
