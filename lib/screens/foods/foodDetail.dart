import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royalkitchen/bloc/food_bloc.dart';
import 'package:royalkitchen/config/colors.dart';
import 'package:royalkitchen/states/food_state.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FoodDetails extends StatefulWidget {
  FoodDetails({Key? key}) : super(key: key);

  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  Map<String, dynamic> values = {
    'Extra Chicken': {'price': 5.00, 'checked': false},
    'Sausage': {'price': 6.00, 'checked': false},
    'Fried Egg': {'price': 1.00, 'checked': false}
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _foodDetailParent(context));
  }

  Widget _foodDetailParent(BuildContext context) {
    return _foodAppBar();
  }

  Widget _foodAppBar() {
    return BlocBuilder<FoodBloc, FoodState>(
        builder: (BuildContext context, FoodState state) {
      return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool isScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                floating: true,
                snap: false,
                pinned: true,
                leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.pop(context)),
                elevation: .5,
                title: Text(isScrolled ? 'Royal Kitchen' : '',
                    style: const TextStyle(fontSize: 16, color: Colors.white)),
                backgroundColor: KColors.kPrimaryColor,
                expandedHeight: MediaQuery.of(context).size.height * .45,
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: 'My hero tag',
                    child: Image(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                          state.food.image['data']['attributes']['url']),
                    ),
                  ),
                ),
              ),
            )
          ];
        },
        body: _foodDetailBody(),
      );
    });
  }

  Widget _foodDetailBody() {
    return Builder(builder: (BuildContext context) {
      return CustomScrollView(
        slivers: <Widget>[
          SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
          SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    _mainDetails(),
                    _divider(),
                    _additional(),
                    _divider(),
                    _delivery(),
                    _orderButton(),
                  ],
                ),
              ))
        ],
      );
    });
  }

  Widget _mainDetails() {
    return BlocBuilder<FoodBloc, FoodState>(
        builder: (BuildContext context, FoodState state) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(state.food.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(state.food.description),
                  const SizedBox(height: 10),
                  Text.rich(TextSpan(text: 'GHS ', children: <InlineSpan>[
                    TextSpan(
                        text: state.food.price.toString(),
                        style: const TextStyle(fontSize: 14))
                  ])),
                ],
              ),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.favorite))
          ],
        ),
      );
    });
  }

  Widget _additional() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Options', style: TextStyle(fontWeight: FontWeight.bold)),
          Column(
            children: values.keys.map((String key) {
              return CheckboxListTile(
                activeColor: KColors.kSecondaryColor,
                enableFeedback: true,
                shape: const CircleBorder(),
                title: Text(
                  key,
                  style: const TextStyle(
                      color: KColors.kTextColorDark, fontSize: 14),
                ),
                subtitle: Text('GHS ${values[key]['price'].toString()}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12)),
                value: values[key]['checked'],
                onChanged: (bool? val) {
                  setState(() => values[key]['checked'] = val!);
                  print(values);
                },
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  Widget _delivery() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text('Select delivery'),
    );
  }

  Widget _divider() {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Divider(
        height: .2,
      ),
    );
  }

  Widget _orderButton() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
          onPressed: () {},
          child: const Text(
            'Continue | GHS 20.00',
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}
