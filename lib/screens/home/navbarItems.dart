import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royalkitchen/bloc/basket_bloc.dart';
import 'package:royalkitchen/bloc/customer_bloc.dart';
import 'package:royalkitchen/bloc/favorite_bloc.dart';
import 'package:royalkitchen/config/colors.dart';
import 'package:badges/badges.dart';
import 'package:royalkitchen/states/favorite_state.dart';

List<BottomNavigationBarItem> navItems = [
  const BottomNavigationBarItem(
      label: 'Home',
      icon: Icon(Icons.home),
      backgroundColor: KColors.kPrimaryColor),
  const BottomNavigationBarItem(
      label: 'Search',
      icon: Icon(Icons.search_rounded),
      backgroundColor: KColors.kPrimaryColor),
  BottomNavigationBarItem(
    icon: BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (BuildContext context, FavoriteState state) {
        return Badge(
          badgeContent: Text(
            state.allFavorites.length.toString(),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          child: const Icon(Icons.favorite_rounded),
          badgeColor: KColors.kSecondaryColor,
        );
      },
    ),
    label: 'Favorites',
    backgroundColor: KColors.kPrimaryColor,
  ),
  const BottomNavigationBarItem(
      label: 'Settings',
      icon: Icon(Icons.settings),
      backgroundColor: KColors.kPrimaryColor),
];
