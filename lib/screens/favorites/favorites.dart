import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royalkitchen/bloc/favorite_bloc.dart';
import 'package:royalkitchen/config/colors.dart';
import 'package:royalkitchen/models/food_model.dart';
import 'package:royalkitchen/screens/foods/components.dart';
import 'package:royalkitchen/states/favorite_state.dart';
import 'package:royalkitchen/states/food_state.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(child: SafeArea(child: _foodParent()), color: Colors.white);
  }

  Widget _foodParent() {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool isScrolled) {
          return <Widget>[_foodHeader(context)];
        },
        body: _foodBody());
  }

  Widget _foodHeader(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      automaticallyImplyLeading: false,
      elevation: .2,
      title: const Text('Browse Foods',
          style: TextStyle(
              fontSize: 16,
              color: KColors.kTextColorDark,
              fontWeight: FontWeight.bold)),
      backgroundColor: Colors.white,
      expandedHeight: MediaQuery.of(context).size.height * .06,
    );
  }

  Widget _foodBody() {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (BuildContext context, FavoriteState state) {
      return state.allFavorites.isNotEmpty
          ? ListView.builder(
              itemCount: state.allFavorites.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int i) {
                return FoodCard(food: state.allFavorites[i].food);
              })
          : const Center(
              child: Text.rich(
                  TextSpan(text: 'Add food to ', children: <InlineSpan>[
                TextSpan(
                    text: "Favorites ",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic)),
                TextSpan(text: 'to show them here')
              ])),
            );
    });
  }
}
