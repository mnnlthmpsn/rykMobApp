import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royalkitchen/events/food_event.dart';
import 'package:royalkitchen/models/food_model.dart';
import 'package:royalkitchen/repos/food_repo.dart';
import 'package:royalkitchen/states/food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final FoodRepository foodRepository;

  FoodBloc({ required this.foodRepository }): super(FoodState(foods: [])){
    on<GetAllFoods>((event, emit) async {
      List<Food> allFoods = await foodRepository.reqFoods();
      emit(state.copyWith(foods: allFoods));
    });
  }
}