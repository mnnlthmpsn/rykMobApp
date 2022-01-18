import 'package:royalkitchen/models/customer_model.dart';
import 'package:royalkitchen/models/food_model.dart';

abstract class FavoriteEvent {}

class GetAllFavorites extends FavoriteEvent {
  final String custEmail;

  GetAllFavorites({ required this.custEmail });
}

class AddFavorite extends FavoriteEvent {
  final int foodId;
  final String customer;

  AddFavorite({ required this.foodId, required this.customer });
}

class DeleteFavorite extends FavoriteEvent {
  final int favoriteID;

  DeleteFavorite({ required this.favoriteID });
}