import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royalkitchen/bloc/customer_bloc.dart';
import 'package:royalkitchen/bloc/favorite_bloc.dart';
import 'package:royalkitchen/events/customer_event.dart';
import 'package:royalkitchen/events/favorite_event.dart';
import 'package:royalkitchen/models/customer_model.dart';
import 'package:royalkitchen/models/favorite_model.dart';
import 'package:royalkitchen/screens/foods/components.dart';
import 'package:royalkitchen/states/favorite_state.dart';
import 'package:royalkitchen/utils/helpers.js.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {

  @override
  void initState() {
    String email = context.read<CustomerBloc>().state.email;
    context.read<FavoriteBloc>().add(GetAllFavorites(custEmail: email));
    super.initState();
  }

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
          List<Favorite> favorites = state.allFavorites!;
          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: favorites.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int i) {
                if (favorites.isNotEmpty) {
                  return Text(favorites[i].foodId.toString());
                }
                return const Text('Error retrieving items');
              });
        });
  }
}
