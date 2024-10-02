import 'package:flucommerce/data/models/contact_details.dart';

List<User> userFromJson(List list) =>
    List<User>.from(list.map((x) => User.fromJson(x)));

class User {
  User({
    required this.id,
    required this.email,
    required this.username,
    this.firstName,
    this.lastName,
    this.billing,
    this.shipping,
  });

  final int id;
  final String email;
  final String username;
  final String? firstName;
  final String? lastName;
  final ContactDetails? billing;
  final ContactDetails? shipping;

  User copyWith({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? username,
    ContactDetails? billing,
    ContactDetails? shipping,
  }) =>
      User(
        id: id ?? this.id,
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        username: username ?? this.username,
        billing: billing ?? this.billing,
        shipping: shipping ?? this.shipping,
      );

  factory User.insertable({required String email, required String username}) {
    return User(
      id: 0,
      email: email,
      username: username,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        billing: json["billing"] == null
            ? null
            : ContactDetails.fromJson(json["billing"]),
        shipping: json["shipping"] == null
            ? null
            : ContactDetails.fromJson(json["shipping"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "username": username,
        "first_name": firstName,
        "last_name": lastName,
        "billing": billing?.toJson(),
        "shipping": shipping?.toJson(),
      };
}
