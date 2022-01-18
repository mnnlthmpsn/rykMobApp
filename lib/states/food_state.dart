import 'package:royalkitchen/models/food_model.dart';

class FoodState {
  final List<Food> foods;

  FoodState({ required this.foods});

  FoodState copyWith({ List<Food>? foods }) {
    return FoodState(foods: foods ?? this.foods);
  }
}