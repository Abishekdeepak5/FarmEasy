class User {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String landmark;

  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.landmark,
  });

  // Convert JSON to Record object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      landmark: json['landmark']
    );
  }
}
