import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royalkitchen/bloc/basket_bloc.dart';
import 'package:royalkitchen/config/colors.dart';
import 'package:royalkitchen/states/basket_state.dart';

class Basket extends StatelessWidget {
  const Basket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(child: _foodParent()),
    );
  }

  Widget _foodParent() {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool isScrolled) {
          return <Widget>[_basketHeader(context)];
        },
        body: _basketBody());
  }

  Widget _basketHeader(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      automaticallyImplyLeading: false,
      elevation: .2,
      title: const Text('Browse Basket',
          style: TextStyle(
              fontSize: 16,
              color: KColors.kTextColorDark,
              fontWeight: FontWeight.bold)),
      backgroundColor: Colors.white,
      expandedHeight: MediaQuery.of(context).size.height * .06,
    );
  }

  Widget _basketBody() {
    return BlocBuilder<BasketBloc, BasketState>(
        builder: (BuildContext context, BasketState state) {
          return state.allBasketItems.isNotEmpty
              ? ListView.builder(
              itemCount: state.allBasketItems.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int i) {
                return Text('hold on');
              })
              : const Center(
            child: Text.rich(
                TextSpan(text: 'Add food to ', children: <InlineSpan>[
                  TextSpan(
                      text: "Basket ",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic)),
                  TextSpan(text: 'to show them here')
                ])),
          );
        });
  }
}
