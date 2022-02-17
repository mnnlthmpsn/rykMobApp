import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royalkitchen/events/food_event.dart';
import 'package:royalkitchen/models/food_model.dart';
import 'package:royalkitchen/repos/food_repo.dart';
import 'package:royalkitchen/states/food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final FoodRepository foodRepository;

  FoodBloc({required this.foodRepository})
      : super(FoodState(foods: [], food: Food(0, '', '', 0.0, false, '', []))) {
    on<GetAllFoods>((event, emit) async {
      List<Food> allFoods = await foodRepository.reqFoods();
      emit(state.copyWith(foods: allFoods));
    });

    on<SetSingleFood>((event, emit) async {
      emit(state.copyWith(food: event.food));
    });

    on<SetFoods>((event, emit) async {
      emit(state.copyWith(foods: event.foods));
    });
  }
}
