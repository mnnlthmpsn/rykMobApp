import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royalkitchen/bloc/customer_bloc.dart';
import 'package:royalkitchen/bloc/favorite_bloc.dart';
import 'package:royalkitchen/bloc/food_bloc.dart';
import 'package:royalkitchen/config/colors.dart';
import 'package:royalkitchen/events/customer_event.dart';
import 'package:royalkitchen/events/favorite_event.dart';
import 'package:royalkitchen/models/customer_model.dart';
import 'package:royalkitchen/models/food_model.dart';
import 'package:royalkitchen/repos/customer_repo.dart';
import 'package:royalkitchen/repos/favorite_repo.dart';
import 'package:royalkitchen/repos/food_repo.dart';
import 'package:royalkitchen/states/favorite_state.dart';
import 'package:royalkitchen/utils/helpers.js.dart';

class FoodCard extends StatefulWidget {
  final Food food;

  const FoodCard({Key? key, required this.food}) : super(key: key);

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  void getCustomer() async {
    context.read<CustomerBloc>().add(GetCustomerFromSharedPreferences());
  }

  @override
  void initState() {
    getCustomer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return foodCard(context, widget.food);
  }
}

Widget foodCard(context, Food food) {
  return SizedBox(
    width: double.infinity,
    child: Column(
      children: [
        _foodImage(context, food),
        Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              _foodDetails(context, food),
              _foodActions(context, food)
            ],
          ),
        )
      ],
    ),
  );
}

Widget _foodImage(context, Food food) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.width * .4,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
            image: NetworkImage(food.image['data']['attributes']['url']),
            fit: BoxFit.cover)),
  );
}

Widget _foodDetails(context, Food food) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(food.name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      Text.rich(TextSpan(text: 'GHS ', children: <InlineSpan>[
        TextSpan(
            text: food.price.toString(), style: const TextStyle(fontSize: 16))
      ]))
    ],
  );
}

Widget _foodActions(BuildContext context, Food food) {
  return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
    IconButton(
        onPressed: () =>
            showToast(context, 'success', 'Item added successfully'),
        icon: const Icon(Icons.shopping_basket),
        padding: const EdgeInsets.all(1),
        color: KColors.kTextColorDark,
        enableFeedback: true),
    IconButton(
        onPressed: () {
          String customer = context.read<CustomerBloc>().state.email;
          context
              .read<FavoriteBloc>()
              .add(AddFavorite(foodId: food.id!, customer: customer));
        },
        icon: const Icon(Icons.favorite_rounded),
        padding: const EdgeInsets.all(1),
        color: KColors.kTextColorDark,
        splashColor: KColors.kTextColorDark.withOpacity(.15),
        enableFeedback: true)
  ]);
}