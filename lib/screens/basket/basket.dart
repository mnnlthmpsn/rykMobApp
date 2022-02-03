import 'package:flutter/material.dart';

class Basket extends StatelessWidget {
  const Basket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Material(child: SafeArea(child: _basketParent()));

  Widget _basketParent() {
    return Text('Basket parent');
  }
}
