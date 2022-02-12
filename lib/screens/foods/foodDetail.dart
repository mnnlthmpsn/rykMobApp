import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_place/google_place.dart';
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
  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  final TextEditingController _searchFieldController = TextEditingController();

  @override
  void initState() {
    googlePlace = GooglePlace('AIzaSyCTrqlPGpXrtHJsmylPKzjmCr1ljWolLLU');
    super.initState();
  }

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Location'),
          const SizedBox(height: 5),
          Container(
            height: 50,
            child: TextField(
                keyboardType: TextInputType.text,
                cursorWidth: 1,
                controller: _searchFieldController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    autoCompleteSearch(value);
                  } else {
                    if (predictions.isNotEmpty && mounted) {
                      setState(() => predictions = []);
                    }
                  }
                },
                cursorColor: KColors.kTextColorDark,
                style: const TextStyle(
                    color: KColors.kTextColorDark, fontSize: 14),
                decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    labelText: 'Delivery Location',
                    labelStyle: TextStyle(fontSize: 16),
                    prefixIcon: Icon(
                      Icons.location_on_outlined,
                      size: 16,
                    ))),
          ),
          const SizedBox(height: 2),
          SizedBox(
            height: predictions.isNotEmpty
                ? MediaQuery.of(context).size.height * .25
                : 0,
            child: ListView.builder(
                itemCount: predictions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const CircleAvatar(
                        child: Icon(
                      Icons.pin_drop,
                      color: Colors.white,
                      size: 15,
                    )),
                    title: Text(predictions[index].description!,
                        style: const TextStyle(
                            fontSize: 14, color: KColors.kGreyColor)),
                    onTap: () {
                      _searchFieldController.value = TextEditingValue(
                          text: predictions[index].description!);
                    },
                  );
                }),
          )
        ],
      ),
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

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      print(result.predictions);
      setState(() => predictions = result.predictions!);
    }
  }
}
