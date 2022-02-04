import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:royalkitchen/models/food_model.dart';

const String url = 'https://royalkitchen-101.herokuapp.com/api/foods';

class FoodRepository {
  Future<List<Food>> reqFoods() async {
    return await http
        .get(Uri.parse(
            '$url?populate=image&fields=name,description,price,discount,available'))
        .then((res) {
      dynamic response = jsonDecode(res.body);
      return (response['data'] as List)
          .map((food) => Food.fromJson(food))
          .toList();
    }).catchError((err) => throw err);
  }

  Future<Food> getFoodByID(String foodID) async {
    return await http
        .get(Uri.parse(
            '$url?populate=image&fields=name,description,price,discount,available&filters[id]=$foodID'))
        .then((res) {
      dynamic temp = jsonDecode(res.body);
      Food food = Food.fromJson(temp['data'][0]);
      return food;
    }).catchError(() {});
  }
}
