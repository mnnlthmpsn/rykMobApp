import 'package:bot_toast/bot_toast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:royalkitchen/models/food_model.dart';

const String url = 'https://royalkitchen-101.herokuapp.com/api/foods';

class FoodRepository {
  Future<List<Food>> reqFoods() async {
    BotToast.showLoading();
    try {
      dynamic res = await http.get(Uri.parse(
          '$url?populate=image&fields=name,description,price,discount,available'));
      dynamic response = jsonDecode(res.body);
      return (response['data'] as List)
          .map((food) => Food.fromJson(food))
          .toList();
    } catch (err) {
      BotToast.showText(text: 'Sorry an error occured');
      rethrow;
    } finally {
      BotToast.closeAllLoading();
    }
  }

  Future<Food> getFoodByID(String foodID) async {
    BotToast.showLoading();

    try {
      dynamic res = await http.get(Uri.parse(
          '$url?populate=image&fields=name,description,price,discount,available&filters[id]=$foodID'));
      dynamic temp = jsonDecode(res.body);
      Food food = Food.fromJson(temp['data'][0]);
      return food;
    } catch (err) {
      BotToast.showText(text: err.toString());
      rethrow;
    } finally {
      BotToast.closeAllLoading();
    }
  }
}
