import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royalkitchen/bloc/customer_bloc.dart';
import 'package:royalkitchen/bloc/favorite_bloc.dart';
import 'package:royalkitchen/bloc/food_bloc.dart';
import 'package:royalkitchen/config/colors.dart';
import 'package:royalkitchen/config/themes.dart';
import 'package:royalkitchen/repos/customer_repo.dart';
import 'package:royalkitchen/repos/favorite_repo.dart';
import 'package:royalkitchen/repos/food_repo.dart';
import 'package:royalkitchen/screens/checkout/checkout.dart';
import 'package:royalkitchen/screens/foods/foods.dart';
import 'package:royalkitchen/screens/home/home.dart';
import 'package:royalkitchen/screens/onBoarding/onBoarding.dart';
import 'package:royalkitchen/screens/register/register.dart';
import 'package:royalkitchen/screens/splashscreen/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FoodBloc foodBloc = FoodBloc(foodRepository: FoodRepository());
  CustomerBloc customerBloc = CustomerBloc(customerRepo: CustomerRepository());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Themes.kThemeData,
      routes: {
        '/': (context) => const Splash(),
        'on_boarding': (context) => OnBoarding(),
        'home': (context) => const Home(),
        'checkout': (context) => const Checkout(),
        'register': (context) => BlocProvider.value(
              value: customerBloc,
              child: Register(),
            )
      },
    );
  }

  @override
  void dispose() {
    foodBloc.close();
    customerBloc.close();
    super.dispose();
  }
}
