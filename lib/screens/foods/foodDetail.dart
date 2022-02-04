import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royalkitchen/bloc/food_bloc.dart';
import 'package:royalkitchen/config/colors.dart';
import 'package:royalkitchen/states/food_state.dart';

class FoodDetails extends StatelessWidget {
  const FoodDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _foodBody(),
      ),
    );
  }

  Widget _foodBody() {
    return CustomScrollView(
      slivers: [_sliverAppBar(), _foodDetails()],
    );
  }

  Widget _sliverAppBar() {
    return BlocBuilder<FoodBloc, FoodState>(
        builder: (BuildContext context, FoodState state) {
      return SliverAppBar(
        pinned: true,
        title: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white.withOpacity(.2)),
              width: double.infinity,
              height: 50,
              child: Row(
                children: <Widget>[
                  _backIcon(context),
                  const SizedBox(width: 15),
                  _appTitle()
                ],
              ),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        flexibleSpace: Image(
            image: NetworkImage(state.food.image['data']['attributes']['url']),
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center),
        floating: true,
        expandedHeight: MediaQuery.of(context).size.height * .4,
      );
    });
  }

  Widget _foodDetails() {
    return SliverList(delegate: SliverChildBuilderDelegate((context, index) {
      return ListTile(title: Text('Item #$index'));
    }));
  }

  Widget _backIcon(context) {
    return IconButton(
      onPressed: () => Navigator.pop(context, true),
      icon: const Icon(Icons.arrow_back),
      color: Colors.white,
    );
  }

  Widget _appTitle() {
    return BlocBuilder<FoodBloc, FoodState>(
        builder: (BuildContext context, FoodState state) {
      return Text(state.food.name,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white));
    });
  }
}
