import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:royalkitchen/models/favorite_model.dart';
import 'package:royalkitchen/models/food_model.dart';

const String url = 'https://royalkitchen-101.herokuapp.com/api/favorites';

class FavoriteRepository {
  Future<List<Favorite>> reqFavorites(custEmail) async {
    dynamic res = await http
        .get(Uri.parse('$url?populate=food&filters[customer]=$custEmail'))
        .then((res) => jsonDecode(res.body))
        .catchError((err) {});
    return (res['data'] as List).map((favorite) => Favorite.fromJson(favorite)).toList();
  }

  Future<Favorite> addFavorite(payload) async {
    var headers = {"Content-Type": "application/json;charset=UTF-8"};

    // convert to json format
    var encode = json.encode(payload);

    return await http
        .post(
            Uri.parse(
                '$url?populate[food][populate][0]=image'),
            headers: headers,
            body: encode)
        .then((res) {
        var js = jsonDecode(res.body);
        return Favorite.fromJson(js['data']);
    })
        .catchError((err) {});
  }
}
