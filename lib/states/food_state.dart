import 'package:royalkitchen/models/food_model.dart';

class FoodState {
  final List<Food> foods;
  final Food food;

  FoodState({required this.foods, required this.food});

  FoodState copyWith({List<Food>? foods, Food? food}) {
    return FoodState(foods: foods ?? this.foods, food: food ?? this.food);
  }
}
