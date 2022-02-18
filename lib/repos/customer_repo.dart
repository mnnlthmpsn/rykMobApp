import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:royalkitchen/models/customer_model.dart';
import 'package:http/http.dart' as http;
import 'package:royalkitchen/utils/helpers.js.dart';

const String url = 'https://royalkitchen-101.herokuapp.com/api/customers';

class CustomerRepository {
  Future<Customer> addCustomer(dynamic payload) async {
    var headers = {"Content-Type": "application/json;charset=UTF-8"};

    // convert to json format
    var encode = json.encode(payload);

    dynamic res = await http.post(
        Uri.parse('$url?fields=firstname,other_names,email,phone,location'),
        headers: headers,
        body: encode);
    dynamic response = jsonDecode(res.body);

    Customer customer = Customer.fromJson(response['data']);
    String encodedCustomer = jsonEncode({
      'id': customer.id,
      'email': customer.email,
      'firstname': customer.firstname,
      'otherNames': customer.otherNames,
      'phone': customer.phone
    });

    // if successful, store customer in shared preference
    storeInLocalStorage('customer', encodedCustomer, 'str');
    return customer;
  }
}
