import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royalkitchen/bloc/customer_bloc.dart';
import 'package:royalkitchen/bloc/favorite_bloc.dart';
import 'package:royalkitchen/bloc/food_bloc.dart';
import 'package:royalkitchen/config/colors.dart';
import 'package:royalkitchen/events/customer_event.dart';
import 'package:royalkitchen/events/favorite_event.dart';
import 'package:royalkitchen/events/food_event.dart';
import 'package:royalkitchen/models/food_model.dart';
import 'package:royalkitchen/utils/helpers.js.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FoodCard extends StatefulWidget {
  final Food food;
  final String category;
  final int? fid;

  const FoodCard(
      {Key? key, required this.food, this.category = 'GNR', this.fid})
      : super(key: key);

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
    return InkWell(
      onTap: () {
        context.read<FoodBloc>().add(SetSingleFood(food: widget.food));
        newPage(context, 'food-details');
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
        child: foodCard(context, widget.food, widget.category, widget.fid),
      ),
    );
  }
}

Widget foodCard(BuildContext context, Food food, String category, fid) {
  return SizedBox(
    width: double.infinity,
    child: Stack(
      children: <Widget>[
        Column(
          children: [
            _foodImage(context, food),
            Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  _foodDetails(context, food),
                ],
              ),
            )
          ],
        ),
        category == 'FVR'
            ? Positioned(
                top: 10,
                right: 10,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white.withOpacity(0.2)),
                      child: IconButton(
                        onPressed: () {
                          context
                              .read<FavoriteBloc>()
                              .add(DeleteFavorite(favoriteID: fid));
                          context.read<FavoriteBloc>().add(GetAllFavorites(
                              custEmail:
                                  context.read<CustomerBloc>().state.email));
                        },
                        icon: const Icon(Icons.close),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink()
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
            image: CachedNetworkImageProvider(
                '${food.image['data']['attributes']['url']}'),
            // image: NetworkImage(food.image['data']['attributes']['url']),
            fit: BoxFit.cover)),
  );
}

Widget _foodDetails(context, Food food) {
  return Expanded(
    flex: 2,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10),
        Text(food.name,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        Text.rich(TextSpan(
            text: 'GHS ',
            style: const TextStyle(fontSize: 11),
            children: <InlineSpan>[
              TextSpan(
                  text: food.price.toString(),
                  style: const TextStyle(fontSize: 12))
            ]))
      ],
    ),
  );
}

Widget foodHeader(BuildContext context, String title, IconData icon) {
  return SliverAppBar(
    floating: true,
    pinned: true,
    automaticallyImplyLeading: false,
    elevation: .2,
    title: Row(
      children: <Widget>[
        Icon(icon),
        const SizedBox(width: 5),
        Text(title,
            style: const TextStyle(
                fontSize: 16,
                color: KColors.kTextColorDark,
                fontWeight: FontWeight.bold))
      ],
    ),
    backgroundColor: Colors.white,
    expandedHeight: MediaQuery.of(context).size.height * .06,
  );
}

Widget basket() {
  return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.shopping_basket),
      splashRadius: 25);
}
