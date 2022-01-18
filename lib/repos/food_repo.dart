import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:royalkitchen/models/food_model.dart';

const String url = 'https://royalkitchen-101.herokuapp.com/api/foods';

class FoodRepository {
  Future<List<Food>> reqFoods() async {
    dynamic res = await http
        .get(Uri.parse(
            '$url?populate=image&fields=name,description,price,discount,available'))
        .then((res) => jsonDecode(res.body))
        .catchError((err) => {});
    return (res['data'] as List).map((food) => Food.fromJson(food)).toList();
  }
}