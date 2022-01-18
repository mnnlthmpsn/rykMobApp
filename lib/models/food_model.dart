class Food {
  final int? id;
  final String name;
  final String description;
  final double price;
  final bool available;
  final dynamic image;

  Food(this.id, this.name, this.description, this.price, this.available,
      this.image);

  Food.fromJson(dynamic json)
    : id = json['id'],
      name = json['attributes']['name'],
      description = json['attributes']['description'],
      price = double.parse(json['attributes']['price'].toString()),
      available = json['attributes']['available'],
      image = json['attributes']['image'];
}
