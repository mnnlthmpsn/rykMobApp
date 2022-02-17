import 'package:flutter/material.dart';
import 'package:royalkitchen/config/colors.dart';
import 'package:royalkitchen/screens/foods/components.dart';

class Me extends StatelessWidget {
  const Me({Key? key}) : super(key: key);

  static const List<Map<String, dynamic>> menuItems = [
    {'title': 'Account Details', 'route': 'account_details'},
    {'title': 'About', 'route': 'about'},
    {'title': 'Contact', 'route': 'contact'},
    {'title': 'Report Issue', 'route': 'report'},
    {'title': 'Logout', 'route': 'logout'},
  ];

  @override
  Widget build(BuildContext context) {
    return Material(child: SafeArea(child: _meParent()), color: Colors.white);
  }

  Widget _meParent() {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool isScrolled) {
          return <Widget>[foodHeader(context, 'Me', Icons.person)];
        },
        body: _meBody());
  }

  Widget _meBody() {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListTile(
              enableFeedback: true,
              onTap: (){},
              title: Text(menuItems[index]['title'],
                  style: const TextStyle(
                      fontSize: 14, color: KColors.kTextColorDark)),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(),
          );
        },
        itemCount: menuItems.length);
  }
}
