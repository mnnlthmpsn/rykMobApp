import 'package:royalkitchen/models/food_model.dart';

class Favorite {
  final int? id;
  final Food food;
  final String customer;

  Favorite({required this.id, required this.food, required this.customer});

  Favorite.fromJson(dynamic json)
      : id = json['id'],
        food = Food(
            json['attributes']['food']['data']['id'],
            json['attributes']['food']['data']['attributes']['name'],
            json['attributes']['food']['data']['attributes']['description'],
            double.parse(json['attributes']['food']['data']['attributes']
                    ['price']
                .toString()),
            json['attributes']['food']['data']['attributes']['available'],
            json['attributes']['food']['data']['attributes']['image'],
            json['attributes']['food']['data']['attributes']['foodExtras']),
        customer = json['attributes']['customer'];
}
