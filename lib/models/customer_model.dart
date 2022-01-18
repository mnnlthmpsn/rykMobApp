import 'dart:convert';

class Customer {
  final String email;
  final String firstname;
  final String otherNames;
  final String phone;
  final String location;
  final int? id;

  Customer(
      {this.id,
      required this.email,
      required this.firstname,
      required this.otherNames,
      required this.phone,
      required this.location
      });

  Customer.fromJson(dynamic json)
    : id = json['id'],
      email = json['attributes']['email'],
      firstname = json['attributes']['firstname'],
      otherNames = json['attributes']['other_names'],
      phone = json['attributes']['phone'],
      location = json['attributes']['location'];

  static toJson(Customer customer) {
    return jsonEncode(customer);
  }

}