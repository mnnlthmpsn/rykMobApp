import 'package:flutter/material.dart';
import 'package:royalkitchen/config/colors.dart';
import 'package:royalkitchen/models/food_model.dart';
import 'package:royalkitchen/models/order_model.dart';

bool showBottom = false;

Widget orderCard(BuildContext context, Order order, Food food) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
    decoration: BoxDecoration(
        border: Border.all(
            color: KColors.kTextColorDark.withOpacity(.2), width: .5),
        borderRadius: BorderRadius.circular(10)),
    child: ListTile(
      enableFeedback: true,
      onTap: () => showSheet(context, food, order),
      trailing: const Icon(Icons.touch_app_rounded),
      title: Text(food.name,
          style: const TextStyle(fontSize: 14, color: KColors.kTextColorDark)),
      subtitle: Text(order.fulfilled ? 'Delivered' : 'Pending', style: TextStyle(fontSize: 12)),
    ),
  );
}

Future<dynamic> showSheet(BuildContext context, Food food, Order order) {
  return showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10))),
      context: context,
      builder: (context) {
        return bottomSheet(context, food, order);
      });
}

Widget bottomSheet(BuildContext context, Food food, Order order) {
  return SizedBox(
    width: double.infinity,
    height: MediaQuery.of(context).size.height * .3,
    child: AnimatedPadding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        duration: const Duration(milliseconds: 150),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
                alignment: Alignment.center, child: bottomSheetHandle(context)),
            const Text('Order Summary', style: TextStyle(fontSize: 14)),
            const Divider(height: 10),
            const SizedBox(height: 8),
            buildDetail(Icons.restaurant, food.name),
            const SizedBox(height: 10),
            buildDetail(Icons.attach_money_sharp,
                'GHS ${order.total_price.toString()}'),
            const SizedBox(height: 10),
            buildDetail(Icons.location_on, order.delivery_location),
            const SizedBox(height: 10),
            buildDetail(Icons.delivery_dining_rounded,
                order.fulfilled ? 'Delivered' : 'Pending')
          ],
        )),
  );
}

Widget buildDetail(IconData icon, String title) {
  return Row(
    children: <Widget>[
      Icon(icon, size: 14, color: Colors.grey),
      const SizedBox(width: 10),
      Expanded(child: Text(title))
    ],
  );
}

Widget bottomSheetHandle(context) {
  return Container(
    margin: const EdgeInsets.only(bottom: 15),
    width: MediaQuery.of(context).size.width * .3,
    height: 5,
    decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: const BorderRadius.all(Radius.circular(10))),
  );
}
