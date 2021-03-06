import 'dart:async';
import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:royalkitchen/models/favorite_model.dart';

const String url = 'https://royalkitchen-101.herokuapp.com/api/favorites';

class FavoriteRepository {
  Future<List<Favorite>> reqFavorites(custEmail) async {
    BotToast.showLoading();

    try {
      dynamic res = await http.get(Uri.parse(
          '$url?populate[food][populate]=*&filters[customer]=$custEmail'));
      dynamic temp = jsonDecode(res.body);
      BotToast.closeAllLoading();
      return (temp['data'] as List)
          .map((favorite) => Favorite.fromJson(favorite))
          .toList();
    } catch (err) {
      BotToast.showText(
          text: 'Error occured getting favorite items',
          textStyle: const TextStyle(fontSize: 14, color: Colors.white));
      BotToast.closeAllLoading();
      rethrow;
    }
  }

  Future<Favorite> addFavorite(payload) async {
    BotToast.showLoading();
    var headers = {"Content-Type": "application/json;charset=UTF-8"};

    // convert to json format
    var encode = json.encode(payload);

    try {
      dynamic res = await http.post(
          Uri.parse('$url?populate[food][populate]=*'),
          headers: headers,
          body: encode);
      var js = jsonDecode(res.body);
      Favorite temp = Favorite.fromJson(js['data']);
      BotToast.closeAllLoading();
      BotToast.showText(
          text: 'Favorite added successfully',
          textStyle: const TextStyle(fontSize: 14, color: Colors.white));
      return temp;
    } catch (err) {
      BotToast.showText(
          text: 'Error occured Adding to favorite',
          textStyle: const TextStyle(fontSize: 14, color: Colors.white));
      BotToast.closeAllLoading();
      rethrow;
    }
  }

  Future<void> deleteFavorite(int favoriteID) async {
    BotToast.showLoading();
    try {
      await http.delete(Uri.parse('$url/$favoriteID'));
      BotToast.closeAllLoading();
      BotToast.showText(
          text: 'Food removed successfully',
          textStyle: const TextStyle(fontSize: 14, color: Colors.white));
    } catch (err) {
      BotToast.showText(
          text: 'Sorry an error occured',
          textStyle: const TextStyle(fontSize: 14, color: Colors.white));
      BotToast.closeAllLoading();
      rethrow;
    }
  }
}
