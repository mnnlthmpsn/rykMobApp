class Favorite {
  final int? id;
  final int foodId;
  final String customer;

  Favorite({ required this.id, required this.foodId, required this.customer });

  Favorite.fromJson(dynamic json)
    : id = json['id'],
      foodId = json['attributes']['food']['data']['id'],
      customer = json['attributes']['customer'];
}