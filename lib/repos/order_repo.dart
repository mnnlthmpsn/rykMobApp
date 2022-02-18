import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:royalkitchen/models/order_model.dart';

const String url = 'https://royalkitchen-101.herokuapp.com/api/orders';

class OrderRepository {
  Future<Order> addOrder(payload) async {
    BotToast.showLoading();
    var headers = {"Content-Type": "application/json;charset=UTF-8"};

    // convert to json format
    var encode = json.encode(payload);

    dynamic res = await http.post(Uri.parse('$url?populate=*'),
        headers: headers, body: encode);
    dynamic response = jsonDecode(res.body);

    BotToast.closeAllLoading();
    return Order.fromJson(response['data']);
  }

  Future<List<Order>> getAllOrders(custEmail) async {
    try {
      dynamic res = await http
          .get(Uri.parse('$url?populate=*&filters[customer]=$custEmail'));
      dynamic temp = jsonDecode(res.body);
      BotToast.closeAllLoading();
      return (temp['data'] as List)
          .map((order) => Order.fromJson(order))
          .toList();
    } catch (err) {
      print(err);
      BotToast.showText(
          text: 'Error occured getting Order items',
          textStyle: const TextStyle(fontSize: 14, color: Colors.white));
      BotToast.closeAllLoading();
      rethrow;
    }
  }
}
