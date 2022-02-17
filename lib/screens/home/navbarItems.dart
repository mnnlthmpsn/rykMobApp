import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royalkitchen/bloc/favorite_bloc.dart';
import 'package:royalkitchen/states/favorite_state.dart';

List<BottomNavigationBarItem> navItems = [
  BottomNavigationBarItem(
      label: 'Home',
      icon: const Icon(Icons.home),
      backgroundColor: Colors.grey.shade100),
  BottomNavigationBarItem(
    icon: const Icon(Icons.shopping_basket_rounded),
    label: 'Basket',
    backgroundColor: Colors.grey.shade100,
  ),
  BottomNavigationBarItem(
    icon: const Icon(Icons.favorite_rounded),
    label: 'Favorites',
    backgroundColor: Colors.grey.shade100,
  ),
  BottomNavigationBarItem(
      label: 'Me',
      icon: const Icon(Icons.person),
      backgroundColor: Colors.grey.shade100),
];
