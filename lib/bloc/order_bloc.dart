import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royalkitchen/events/order_event.dart';
import 'package:royalkitchen/models/order_model.dart';
import 'package:royalkitchen/repos/order_repo.dart';
import 'package:royalkitchen/states/order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;

  OrderBloc({required this.orderRepository}) : super(OrderState()) {
    on<SetOrders>((event, emit) async {
      List<Order> allOrders =
          await orderRepository.getAllOrders(event.customer);
      emit(state.copyWith(allOrders: allOrders));
    });

    on<AddOrder>((event, emit) async {
      try {
        dynamic payload = {
          'data': {
            'food': event.order.food,
            'delivery_location': event.order.delivery_location,
            'extra_note': event.order.extra_note,
            'extras': event.order.extras.map((e) => Extras(e.title, e.price).toJson()).toList(),
            'total_price': event.order.total_price,
            'customer': event.order.customer
          }
        };

        Order order = await orderRepository.addOrder(payload);
        state.allOrders.add(order);
        emit(state.copyWith(allOrders: state.allOrders));
        BotToast.showText(text: 'Order added successfully', textStyle: TextStyle(fontSize: 14, color: Colors.white));
      } catch (err) {
        BotToast.closeAllLoading();
        BotToast.showText(text: 'Error occured adding order', textStyle: TextStyle(fontSize: 14, color: Colors.white));
      }
    });
  }
}
