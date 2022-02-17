import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royalkitchen/bloc/favorite_bloc.dart';
import 'package:royalkitchen/bloc/food_bloc.dart';
import 'package:royalkitchen/config/colors.dart';
import 'package:royalkitchen/events/favorite_event.dart';
import 'package:royalkitchen/events/food_event.dart';
import 'package:royalkitchen/models/customer_model.dart';
import 'package:royalkitchen/screens/favorites/favorites.dart';
import 'package:royalkitchen/screens/foods/foods.dart';
import 'package:royalkitchen/screens/home/navbarItems.dart';
import 'package:royalkitchen/screens/me/me.dart';
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
          curve: Curves.easeInOut, duration: const Duration(milliseconds: 100));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: (index) => setState(() => _selectedIndex = index),
            children: const <Widget>[
              Foods(),
              Favorites(),
              Center(child: Text('Orders')),
              Me()
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          enableFeedback: true,
          elevation: 0,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: _selectedIndex,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedItemColor: KColors.kPrimaryColor,
          unselectedItemColor: KColors.kTextColorDark,
          onTap: onItemTapped,
          items: navItems.map((item) => item).toList(),
        ));
  }
}
