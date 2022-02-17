import 'package:royalkitchen/models/favorite_model.dart';
import 'package:royalkitchen/models/order_model.dart';

class OrderState {
  List<Order> allOrders;

  OrderState({ this.allOrders = const []});

  OrderState copyWith({List<Order>? allOrders}) {
    return OrderState(
        allOrders: allOrders ?? this.allOrders);
  }
}
