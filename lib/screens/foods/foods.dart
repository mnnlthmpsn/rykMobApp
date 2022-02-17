import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royalkitchen/bloc/food_bloc.dart';
import 'package:royalkitchen/config/colors.dart';
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
  List<Food> filteredFoods = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(child: SafeArea(child: _foodParent()), color: Colors.white);
  }

  Widget _foodParent() {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool isScrolled) {
          return <Widget>[foodHeader(context, 'Foods', Icons.home)];
        },
        body: _foodBody());
  }

  Widget _foodBody() {
    return Column(
      children: <Widget>[
        _buildSearch(context),
        Expanded(
          child: _searchController.text.isNotEmpty && filteredFoods.isEmpty
              ? const Center(child: Text('No foods found'))
              : _renderFood(),
        ),
      ],
    );
  }

  Widget _buildSearch(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SizedBox(
          height: 50,
          child: TextField(
            autofocus: false,
            controller: _searchController,
            onChanged: (text) {
              text = text.toLowerCase();
              List<Food> allFoods = [...context.read<FoodBloc>().state.foods];

              setState(() {
                filteredFoods = allFoods.where((food) {
                  var foodTitle = food.name.toLowerCase();
                  return foodTitle.contains(text);
                }).toList();
              });
            },
            decoration: const InputDecoration(
                hintText: 'Search...',
                prefixIcon:
                    Icon(Icons.search, size: 18, color: KColors.kTextColorDark),
                contentPadding: EdgeInsets.only(bottom: 50 / 2)),
            style: const TextStyle(fontSize: 14, color: KColors.kTextColorDark),
          )),
    );
  }

  Widget _renderFood() {
    return BlocBuilder<FoodBloc, FoodState>(
        builder: (BuildContext context, FoodState state) {
      return ListView.builder(
          itemCount: filteredFoods.isNotEmpty
              ? filteredFoods.length
              : state.foods.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int i) {
            if (filteredFoods.isNotEmpty) {
              return FoodCard(food: filteredFoods[i]);
            }
            if (state.foods.isNotEmpty) {
              return FoodCard(food: state.foods[i]);
            }

            return const Text('Error retrieving items');
          });
    });
  }
}
