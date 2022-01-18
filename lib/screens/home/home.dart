import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royalkitchen/bloc/customer_bloc.dart';
import 'package:royalkitchen/bloc/favorite_bloc.dart';
import 'package:royalkitchen/bloc/food_bloc.dart';
import 'package:royalkitchen/config/colors.dart';
import 'package:royalkitchen/repos/customer_repo.dart';
import 'package:royalkitchen/repos/favorite_repo.dart';
import 'package:royalkitchen/repos/food_repo.dart';
import 'package:royalkitchen/screens/favorites/favorites.dart';
import 'package:royalkitchen/screens/foods/foods.dart';
import 'package:royalkitchen/screens/home/navbarItems.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final PageController _pageController = PageController();

  // blocs
  FoodBloc foodBloc = FoodBloc(foodRepository: FoodRepository());
  FavoriteBloc favoriteBloc = FavoriteBloc(favoriteRepo: FavoriteRepository());
  CustomerBloc customerBloc = CustomerBloc(customerRepo: CustomerRepository());

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
    return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: foodBloc),
          BlocProvider.value(value: favoriteBloc),
          BlocProvider.value(value: customerBloc)
        ],
        child: Scaffold(
            body: SizedBox.expand(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) =>
                    setState(() => _selectedIndex = index),
                children: <Widget>[
                  const Foods(),
                  Container(color: Colors.green),
                  const Favorites(),
                  Container(color: Colors.black)
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
            )));
  }
}
