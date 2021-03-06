import 'package:royalkitchen/models/food_model.dart';

abstract class FoodEvent {}

class GetAllFoods extends FoodEvent {}

class SetSingleFood extends FoodEvent {
  final Food food;

  SetSingleFood({required this.food});
}


class SetFoods extends FoodEvent {
  final List<Food> foods;

  SetFoods({ required this.foods });
}