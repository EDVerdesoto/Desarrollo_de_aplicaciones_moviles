class Order {
  final int id;
  final String clientName;
  final DateTime date;

  Order({required this.id, required this.clientName, required this.date});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as int,
      clientName: json['clientName'] as String,
      // el backend devuelve la fecha como String ⇒ la parseamos
      date: DateTime.parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientName': clientName,
      'date': date.toIso8601String(), // <-- esta línea arregla el error
    };
  }
}
