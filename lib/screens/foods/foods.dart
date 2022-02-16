import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royalkitchen/bloc/food_bloc.dart';
import 'package:royalkitchen/models/food_model.dart';
import 'package:royalkitchen/screens/foods/components.dart';
import 'package:royalkitchen/states/food_state.dart';

class Foods extends StatelessWidget {
  const Foods({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(child: SafeArea(child: _foodParent()), color: Colors.white);
  }

  Widget _foodParent() {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool isScrolled) {
          return <Widget>[foodHeader(context, 'Browse Foods')];
        },
        body: _foodBody());
  }

  Widget _foodBody() {
    return BlocBuilder<FoodBloc, FoodState>(
        builder: (BuildContext context, FoodState state) {
      List<Food> foods = state.foods;
      return ListView.builder(
          itemCount: foods.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int i) {
            if (foods.isNotEmpty) {
              return FoodCard(food: foods[i]);
            }
            return const Text('Error retrieving items');
          });
    });
  }
}
