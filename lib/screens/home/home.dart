import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royalkitchen/bloc/basket_bloc.dart';
import 'package:royalkitchen/bloc/favorite_bloc.dart';
import 'package:royalkitchen/bloc/food_bloc.dart';
import 'package:royalkitchen/config/colors.dart';
import 'package:royalkitchen/events/basket_event.dart';
import 'package:royalkitchen/events/favorite_event.dart';
import 'package:royalkitchen/events/food_event.dart';
import 'package:royalkitchen/models/customer_model.dart';
import 'package:royalkitchen/screens/basket/basket.dart';
import 'package:royalkitchen/screens/favorites/favorites.dart';
import 'package:royalkitchen/screens/foods/foods.dart';
import 'package:royalkitchen/screens/home/navbarItems.dart';
import 'package:royalkitchen/utils/helpers.js.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  late Customer customer;

  final PageController _pageController = PageController();

  @override
  void initState() {
    // get all foods
    context.read<FoodBloc>().add(GetAllFoods());
    getCustomerDetails();
    super.initState();
  }

  getCustomerDetails() async {
    customer = await getCustomerFromLocalStorage();

    // get customer basket items
    context
        .read<BasketBloc>()
        .add(GetAllBasketItems(custEmail: customer.email));

    // get customer favorite items
    context
        .read<FavoriteBloc>()
        .add(GetAllFavorites(custEmail: customer.email));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 150), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _selectedIndex = index),
            children: const <Widget>[
              Foods(),
              Text('Search'),
              Favorites(),
              Basket()
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          enableFeedback: true,
          currentIndex: _selectedIndex,
          selectedItemColor: KColors.kSecondaryColor,
          unselectedItemColor: Colors.white,
          onTap: onItemTapped,
          items: navItems.map((item) => item).toList(),
        ));
  }
}
