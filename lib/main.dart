import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royalkitchen/bloc/basket_bloc.dart';
import 'package:royalkitchen/bloc/customer_bloc.dart';
import 'package:royalkitchen/bloc/favorite_bloc.dart';
import 'package:royalkitchen/bloc/food_bloc.dart';
import 'package:royalkitchen/config/themes.dart';
import 'package:royalkitchen/repos/basket_repo.dart';
import 'package:royalkitchen/repos/customer_repo.dart';
import 'package:royalkitchen/repos/favorite_repo.dart';
import 'package:royalkitchen/repos/food_repo.dart';
import 'package:royalkitchen/screens/checkout/checkout.dart';
import 'package:royalkitchen/screens/foods/foodDetail.dart';
import 'package:royalkitchen/screens/home/home.dart';
import 'package:royalkitchen/screens/onBoarding/onBoarding.dart';
import 'package:royalkitchen/screens/register/register.dart';
import 'package:royalkitchen/screens/splashscreen/splashScreen.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FoodBloc _foodBloc = FoodBloc(foodRepository: FoodRepository());
  final FavoriteBloc _favoriteBloc =
      FavoriteBloc(favoriteRepo: FavoriteRepository());
  final BasketBloc _basketBloc =
      BasketBloc(basketRepository: BasketRepository());
  final CustomerBloc _customerBloc =
      CustomerBloc(customerRepo: CustomerRepository());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _foodBloc),
          BlocProvider.value(value: _basketBloc),
          BlocProvider.value(value: _favoriteBloc),
          BlocProvider.value(value: _customerBloc)
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          builder: BotToastInit(), //1. call BotToastInit
          navigatorObservers: [BotToastNavigatorObserver()],
          title: 'Flutter Demo',
          theme: Themes.kThemeData,
          routes: {
            '/': (context) => const Splash(),
            'on_boarding': (context) => OnBoarding(),
            'home': (context) => const Home(),
            'checkout': (context) => const Checkout(),
            'register': (context) => Register(),
            'food-details': (context) => FoodDetails()
          },
        ));
  }

  @override
  void dispose() {
    _foodBloc.close();
    _basketBloc.close();
    _favoriteBloc.close();
    _customerBloc.close();
    super.dispose();
  }
}
