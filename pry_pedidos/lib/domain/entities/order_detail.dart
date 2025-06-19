class OrderDetail {
  final int id;
  final int orderId;
  final String product;
  final int amount;
  final double unitPrice;

  OrderDetail({
    required this.id,
    required this.orderId,
    required this.product,
    required this.amount,
    required this.unitPrice,
  });

  // ⇢ al recibir JSON del backend
  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      id: json['id'] as int,
      orderId: json['orderId'] as int,
      product: json['product'] as String,
      amount: (json['amount'] as num).toInt(),
      unitPrice: (json['unitPrice'] as num).toDouble(),
    );
  }

  // ⇢ al enviar JSON al backend
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderId': orderId,
      'product': product,
      'amount': amount, // ya es int
      'unitPrice': unitPrice, // ya es double
    };
  }
}
