import 'dart:ui';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_place/google_place.dart';
import 'package:royalkitchen/bloc/customer_bloc.dart';
import 'package:royalkitchen/bloc/favorite_bloc.dart';
import 'package:royalkitchen/bloc/food_bloc.dart';
import 'package:royalkitchen/config/colors.dart';
import 'package:royalkitchen/events/favorite_event.dart';
import 'package:royalkitchen/models/food_model.dart';
import 'package:royalkitchen/models/order_model.dart';
import 'package:royalkitchen/states/food_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:royalkitchen/utils/helpers.js.dart';

class FoodDetails extends StatefulWidget {
  FoodDetails({Key? key}) : super(key: key);

  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];

  late double totalAmt = 0.0;
  late int quantity = 1;
  final double delivery = 5.0;

  final TextEditingController _searchFieldController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _extraNotesController = TextEditingController();

  List<dynamic> values = [];

  @override
  void initState() {
    googlePlace = GooglePlace(dotenv.env['PLACES_API_KEY']!);

    // add checked is false to foodExtras
    List temp = context.read<FoodBloc>().state.food.foodExtras;
    for (Map<String, dynamic> foodItem in temp) {
      foodItem.addAll({'checked': false});
      values.add(foodItem);
    }

    // add price of food to total amount
    setState(() {
      totalAmt = totalAmt + context.read<FoodBloc>().state.food.price;
    });
    super.initState();
  }

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
                    tag: state.food.name,
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
                    _orderQuantity(),
                    _divider(),
                    _delivery(),
                    _divider(),
                    _extraNotes(),
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
          crossAxisAlignment: CrossAxisAlignment.end,
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
                  Text.rich(TextSpan(
                      text: 'GHS ',
                      style: const TextStyle(fontSize: 10),
                      children: <InlineSpan>[
                        TextSpan(
                            text: state.food.price.toString(),
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700)),
                        const TextSpan(text: ' | '),
                        TextSpan(
                            text: 'Delivery: GHS $delivery',
                            style: const TextStyle(fontWeight: FontWeight.bold))
                      ])),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                _addToFavoriteButton(state.food),
                _addToBasketButton(state.food)
              ],
            )
          ],
        ),
      );
    });
  }

  Widget _addToFavoriteButton(Food food) {
    return IconButton(
        onPressed: () => context.read<FavoriteBloc>().add(AddFavorite(
            foodId: food.id!,
            customer: context.read<CustomerBloc>().state.email)),
        icon: const Icon(Icons.favorite));
  }

  Widget _addToBasketButton(Food food) {
    return IconButton(
        onPressed: () {}, icon: const Icon(Icons.shopping_basket));
  }

  Widget _additional() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Extras (Optional)'),
          Column(
            children: values.map((item) {
              return CheckboxListTile(
                activeColor: KColors.kPrimaryColor,
                enableFeedback: true,
                shape: const CircleBorder(),
                title: Text(
                  item['title'],
                  style: const TextStyle(
                      color: KColors.kTextColorDark, fontSize: 16),
                ),
                subtitle: Text('GHS ${item['price'].toString()}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12)),
                value: item['checked'],
                onChanged: (bool? val) {
                  setState(() => item['checked'] = val!);
                  setState(() {
                    item['checked']
                        ? totalAmt += item['price']
                        : totalAmt -= item['price'];
                  });
                },
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  Widget _orderQuantity() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Order Quantity'),
          const SizedBox(height: 5),
          SizedBox(
            height: 50,
            child: NumberInputWithIncrementDecrement(
              onIncrement: (value) =>
                  setState(() => quantity = int.parse(value.toString())),
              onDecrement: (value) =>
                  setState(() => quantity = int.parse(value.toString())),
              initialValue: 1,
              min: 1,
              decIconSize: 20,
              incIconSize: 20,
              widgetContainerDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: .5, color: KColors.kPrimaryColor)),
              numberFieldDecoration: const InputDecoration(
                  border: InputBorder.none, focusedBorder: InputBorder.none),
              controller: _quantityController,
              separateIcons: true,
              onChanged: (value) =>
                  setState(() => quantity = int.parse(value.toString())),
              style:
                  const TextStyle(color: KColors.kTextColorDark, fontSize: 16),
            ),
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
          SizedBox(
            height: 50,
            child: TextField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
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
                    labelStyle: TextStyle(fontSize: 14),
                    contentPadding: EdgeInsets.only(bottom: 50 / 2, right: 10),
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

  Widget _extraNotes() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Extra Notes (Optional)'),
          const SizedBox(height: 5),
          TextField(
            controller: _extraNotesController,
            textInputAction: TextInputAction.done,
            maxLines: 5,
            style: const TextStyle(fontSize: 14, color: KColors.kTextColorDark),
            decoration: const InputDecoration(
                labelText: 'eg. Please don\'t add garden eggs',
                labelStyle: TextStyle(fontSize: 12),
                alignLabelWithHint: true,
                contentPadding: EdgeInsets.all(8)),
          )
        ],
      ),
    );
  }

  Widget _orderButton() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
          onPressed: _placeOrder,
          child: Text(
            'Place Order | GHS ${(totalAmt * quantity) + delivery}',
            style: const TextStyle(color: Colors.white),
          )),
    );
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      setState(() => predictions = result.predictions!);
    }
  }

  void _placeOrder() {
    List<dynamic> temp =
        values.where((foodExtra) => foodExtra['checked']).toList();

    if (_searchFieldController.text.isEmpty) {
      BotToast.showText(
          text: 'Please select Delivery Location',
          textStyle: const TextStyle(fontSize: 14, color: Colors.white));
    } else {
      double totAmt = (totalAmt * quantity) + delivery;
      List<Extras> selectedExtras =
          temp.map((foodExtra) => Extras.fromJson(foodExtra)).toList();

      Order order = Order(
          context.read<FoodBloc>().state.food.id!,
          _searchFieldController.text,
          _extraNotesController.value.text,
          totAmt,
          context.read<CustomerBloc>().state.email,
          selectedExtras);

      order.addOrder();
      newPageDestroyPrevious(context, 'home');
    }
  }
}
