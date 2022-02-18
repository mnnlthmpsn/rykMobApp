import 'package:royalkitchen/repos/order_repo.dart';

class Order {
  OrderRepository orderRepository = OrderRepository();

  final int? id;
  final int food;
  final String delivery_location;
  final bool fulfilled;
  final String extra_note;
  final List<Extras> extras;
  final double total_price;
  final String customer;

  Order(this.id, this.food, this.delivery_location, this.extra_note,
      this.total_price, this.customer, this.extras,
      {this.fulfilled = false});

  Order.fromJson(dynamic json)
      : id = json['id'],
        food = json['attributes']['food']['data']['id'],
        delivery_location = json['attributes']['delivery_location'],
        extra_note = json['attributes']['extra_note'],
        fulfilled = json['attributes']['fulfilled'],
        extras = (json['attributes']['extras'] as List)
            .map((extra) => Extras.fromJson(extra))
            .toList(),
        total_price =
            double.parse(json['attributes']['total_price'].toString()),
        customer = json['attributes']['customer'];

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
