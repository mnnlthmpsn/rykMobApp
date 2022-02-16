import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String url = 'https://royalkitchen-101.herokuapp.com/api/orders';

class OrderRepository {
  static Future<void> addOrder(payload) async {
    BotToast.showLoading();
    var headers = {"Content-Type": "application/json;charset=UTF-8"};

    // convert to json format
    var encode = json.encode(payload);

    try {
      await http.post(Uri.parse(url), headers: headers, body: encode);
      BotToast.closeAllLoading();
      BotToast.showText(text: 'Order placed Successfully');
    } catch (err) {
      BotToast.showText(
          text: 'Sorry an error occured',
          textStyle: const TextStyle(fontSize: 14, color: Colors.white));
    }
  }
}
