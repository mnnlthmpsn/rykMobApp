import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royalkitchen/bloc/customer_bloc.dart';
import 'package:royalkitchen/bloc/favorite_bloc.dart';
import 'package:royalkitchen/config/colors.dart';
import 'package:badges/badges.dart';
import 'package:royalkitchen/events/favorite_event.dart';
import 'package:royalkitchen/repos/favorite_repo.dart';
import 'package:royalkitchen/states/favorite_state.dart';

List<BottomNavigationBarItem> navItems = [
  const BottomNavigationBarItem(
      label: 'Home',
      icon: Icon(Icons.home),
      backgroundColor: KColors.kPrimaryColor),
  BottomNavigationBarItem(
      label: 'Basket',
      icon: Badge(
        badgeContent: const Text(
          '1',
          style: TextStyle(
              color: KColors.kPrimaryColor, fontWeight: FontWeight.bold),
        ),
        child: const Icon(Icons.shopping_basket_rounded),
        badgeColor: KColors.kSecondaryColor,
      ),
      backgroundColor: KColors.kPrimaryColor),
  BottomNavigationBarItem(
    icon: BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (BuildContext context, FavoriteState state) {
        return Badge(
          badgeContent: Text(
            state.allFavorites.length.toString(),
            style: const TextStyle(
                color: KColors.kPrimaryColor, fontWeight: FontWeight.bold),
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
