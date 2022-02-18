import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royalkitchen/bloc/food_bloc.dart';
import 'package:royalkitchen/bloc/order_bloc.dart';
import 'package:royalkitchen/models/food_model.dart';
import 'package:royalkitchen/models/order_model.dart';
import 'package:royalkitchen/screens/foods/components.dart';
import 'package:royalkitchen/screens/orders/components.dart';
import 'package:royalkitchen/states/order_state.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  bool _show = false;

  late Food selectedFood;
  late Order selectedOrder;

  void toggleShow(bool tf, Food food, Order order) {
    setState(() {
      selectedFood = food;
      selectedOrder = order;
      _show = tf;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
          body: SafeArea(
            child: _orderParent(),
          ),
        ),
        color: Colors.white);
  }

  Widget _orderParent() {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool isScrolled) {
          return <Widget>[
            foodHeader(context, 'Orders', Icons.insert_drive_file)
          ];
        },
        body: _orderBody(context));
  }

  Widget _orderBody(BuildContext context) {
    List<Order> allOrders = context.read<OrderBloc>().state.allOrders;
    List<Food> allFoods = context.read<FoodBloc>().state.foods;

    return allOrders.isNotEmpty && allFoods.isNotEmpty
        ? ListView.builder(
            itemCount: allOrders.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int i) {
              Food food =
                  allFoods.where((food) => food.id == allOrders[i].food).first;

              return orderCard(context, allOrders[i], food);
            })
        : const Center(
            child: Text.rich(TextSpan(text: 'No ', children: <InlineSpan>[
              TextSpan(
                  text: "Orders ",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic)),
              TextSpan(text: 'have been made yet')
            ])),
          );
  }
}
