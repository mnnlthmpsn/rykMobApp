import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:royalkitchen/models/basket_model.dart';

const String url = 'https://royalkitchen-101.herokuapp.com/api/cart-items';

class BasketRepository {
  Future<List<Basket>> reqBasketItems(custEmail) async {
    dynamic res = await http
        .get(Uri.parse(
            '$url?populate[food][populate][0]=image&filters[customer]=$custEmail'))
        .then((res) => jsonDecode(res.body))
        .catchError((err) {});
    return (res['data'] as List).map((item) => Basket.fromJson(item)).toList();
  }

  Future<Basket> addBasketItem(payload) async {
    var headers = {"Content-Type": "application/json;charset=UTF-8"};

    // convert to json format
    var encode = json.encode(payload);

    return await http
        .post(Uri.parse('$url?populate[food][populate][0]=image'),
            headers: headers, body: encode)
        .then((res) {
      var js = jsonDecode(res.body);
      Basket temp = Basket.fromJson(js['data']);
      return temp;
    }).catchError((err) {});
  }
}
