import 'package:royalkitchen/models/basket_model.dart';

class BasketState {
  List<Basket> allBasketItems;
  Basket? basketItem;

  BasketState({this.allBasketItems = const [], this.basketItem});

  BasketState copyWith({List<Basket>? allBasketItems, Basket? basketItem}) {
    return BasketState(
        allBasketItems: allBasketItems ?? this.allBasketItems,
        basketItem: basketItem ?? this.basketItem);
  }
}
