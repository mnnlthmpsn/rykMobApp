import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royalkitchen/events/basket_event.dart';
import 'package:royalkitchen/models/basket_model.dart';
import 'package:royalkitchen/repos/basket_repo.dart';
import 'package:royalkitchen/states/basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final BasketRepository basketRepository;

  BasketBloc({required this.basketRepository}) : super(BasketState()) {
    on<GetAllBasketItems>((event, emit) async {
      List<Basket> allBasketItems =
          await basketRepository.reqBasketItems(event.custEmail);
      emit(state.copyWith(allBasketItems: allBasketItems));
    });

    on<AddBasketItem>((event, emit) async {
      Basket basketItem = await basketRepository.addBasketItem({
        'data': {'customer': event.customer, 'food': event.foodId}
      });

      state.allBasketItems.add(basketItem);
      emit(state.copyWith(allBasketItems: state.allBasketItems));
    });
  }
}
