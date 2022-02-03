import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royalkitchen/bloc/favorite_bloc.dart';
import 'package:royalkitchen/screens/foods/components.dart';
import 'package:royalkitchen/states/favorite_state.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(child: SafeArea(child: _favoriteParent()));
  }

  Widget _favoriteParent() {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            const Align(
                alignment: Alignment.centerLeft,
                child: Text('Your Favorites',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
            const SizedBox(height: 10),
            _favoriteBody()
          ],
        ),
      ),
    );
  }

  Widget _favoriteBody() {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (BuildContext context, FavoriteState state) {
      return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.allFavorites.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int i) {
            return FoodCard(
              food: state.allFavorites[i].food,
              category: 'FVR',
            );
          });
    });
  }
}
