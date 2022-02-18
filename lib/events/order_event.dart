import 'package:royalkitchen/models/order_model.dart';

abstract class OrderEvent {}

class SetOrders extends OrderEvent {
  final String customer;

  SetOrders({ required this.customer});
}

class AddOrder extends OrderEvent {
  final Order order;

  AddOrder({ required this.order });
}