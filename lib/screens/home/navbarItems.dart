import 'package:flutter/material.dart';

List<BottomNavigationBarItem> navItems = [
  BottomNavigationBarItem(
      label: 'Foods',
      icon: const Icon(Icons.restaurant_rounded),
      backgroundColor: Colors.grey.shade100),
  BottomNavigationBarItem(
    icon: const Icon(Icons.favorite_rounded),
    label: 'Favorites',
    backgroundColor: Colors.grey.shade100,
  ),
  BottomNavigationBarItem(
    icon: const Icon(Icons.insert_drive_file),
    label: 'Orders',
    backgroundColor: Colors.grey.shade100,
  ),
  BottomNavigationBarItem(
      label: 'Me',
      icon: const Icon(Icons.person),
      backgroundColor: Colors.grey.shade100),
];
