class User {
  final String user_id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String address;//necesario?
  final String city;
  final String province;
  final String phone;
  final String zipCode;

  User({
    required this.user_id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.address,
    required this.city,
    required this.province,
    required this.phone,
    required this.zipCode
  });

  // Convertir de JSON a User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      user_id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
      address: json['address'],
      city: json['city'],
      province: json['province'],
      phone: json['phone'],
      zipCode: json['zipCode'],
    );
  }

  // Convertir de User a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': user_id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'address': address,
      'city': city,
      'province': province,
      'phone': phone,
      'zipCode': zipCode,
    };
  }
}