class Order {
  final int id;
  final String clientName;
  final DateTime date;

  Order({
    required this.id,
    required this.clientName,
    required this.date,
  });

  factory Order.fromJson(Map<String, dynamic> json){
    return Order(
      id: json['id'], 
      clientName: json['clientName'], 
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'clientName': clientName,
      'date': date,
    };
  }

}