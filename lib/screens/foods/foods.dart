import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royalkitchen/bloc/food_bloc.dart';
import 'package:royalkitchen/events/food_event.dart';
import 'package:royalkitchen/models/food_model.dart';
import 'package:royalkitchen/screens/foods/components.dart';
import 'package:royalkitchen/states/food_state.dart';

class Foods extends StatefulWidget {
  const Foods({Key? key}) : super(key: key);

  @override
  State<Foods> createState() => _FoodsState();
}

class _FoodsState extends State<Foods> {
  @override
  void initState() {
    context.read<FoodBloc>().add(GetAllFoods());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(child: SafeArea(child: _foodParent()));
  }

  Widget _foodParent() {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
        child: Column(
          children: <Widget>[
            _foodHeader(),
            const SizedBox(height: 10),
            const Align(
                alignment: Alignment.centerLeft,
                child: Text('Browse Foods',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
            const SizedBox(height: 10),
            _foodBody()
          ],
        ),
      ),
    );
  }

  Widget _foodHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const SizedBox.shrink(),
        IconButton(onPressed: () {}, icon: const Icon(Icons.search))
      ],
    );
  }

  Widget _foodBody() {
    return BlocBuilder<FoodBloc, FoodState>(
        builder: (BuildContext context, FoodState state) {
      List<Food> foods = state.foods;
      return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
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
