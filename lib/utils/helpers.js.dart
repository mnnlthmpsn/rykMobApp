import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:royalkitchen/config/colors.dart';
import 'package:royalkitchen/models/customer_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void newPage(BuildContext context, String routeName) {
  Navigator.pushNamed(context, routeName);
}

void newPageDestroyPrevious(BuildContext context, String routeName) {
  Navigator.pushReplacementNamed(context, routeName);
}

void dismissKeyboard(context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

dynamic storeInLocalStorage(key, val, type) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  switch (type) {
    case 'int':
      {
        await prefs.setInt(key, val);
      }
      break;
    case 'str':
      {
        var temp_val;

        // do not trim other names ('could be two names')
        key == 'other_names' ? temp_val = val : temp_val = val.trim();
        await prefs.setString(key, temp_val);
      }
      break;
    case 'bool':
      {
        await prefs.setBool(key, val);
      }
      break;
  }
}

Future<Customer> getCustomerFromLocalStorage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String customer = (prefs.getString('customer') ?? '');
  dynamic res = jsonDecode(customer);
  return Customer(
      id: res['id'],
      email: res['email'],
      firstname: res['firstname'],
      otherNames: res['otherNames'],
      phone: res['phone'],
      location: res['location']);
}
