import 'dart:convert';

import 'package:royalkitchen/repos/order_repo.dart';

class Order {
  final int food;
  final String delivery_location;
  final String extra_note;
  final List<Extras> extras;
  final double total_price;
  final String customer;

  Order(this.food, this.delivery_location, this.extra_note, this.total_price,
      this.customer, this.extras);

  void addOrder() async {
    dynamic payload = {
      'data': {
        'food': food,
        'delivery_location': delivery_location,
        'extra_note': extra_note,
        'extras': extras.map((e) => Extras(e.title, e.price).toJson()).toList(),
        'total_price': total_price,
        'customer': customer
      }
    };

    OrderRepository.addOrder(payload);
  }
}

class Extras {
  final String title;
  final double price;

  Extras(this.title, this.price);

  Extras.fromJson(dynamic json)
      : title = json['title'],
        price = double.parse(json['price'].toString());

  Map<String, dynamic> toJson() => {'title': title, 'price': price};
}
