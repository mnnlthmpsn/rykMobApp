import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royalkitchen/bloc/favorite_bloc.dart';
import 'package:royalkitchen/screens/foods/components.dart';
import 'package:royalkitchen/states/favorite_state.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(child: SafeArea(child: _foodParent()), color: Colors.white);
  }

  Widget _foodParent() {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool isScrolled) {
          return <Widget>[foodHeader(context, 'Favorites', Icons.favorite)];
        },
        body: _foodBody());
  }

  Widget _foodBody() {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (BuildContext context, FavoriteState state) {
      return state.allFavorites.isNotEmpty
          ? ListView.builder(
              itemCount: state.allFavorites.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int i) {
                return FoodCard(food: state.allFavorites[i].food, category: 'FVR', fid: state.allFavorites[i].id);
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
