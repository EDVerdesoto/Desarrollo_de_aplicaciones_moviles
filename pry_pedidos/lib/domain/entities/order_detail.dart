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

  factory OrderDetail.fromJson(Map<String, dynamic> json){
    return OrderDetail(
      id: json['id'],
      orderId: json['orderId'],
      product: json['product'],
      amount: json['amount'],
      unitPrice: json['unitPrice'].toDouble(),
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'orderId': orderId,
      'product': product,
      'amount': amount,
      'unitPrice': unitPrice,
    };
  }
}