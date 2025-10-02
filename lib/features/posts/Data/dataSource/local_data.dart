import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:postsapp_clean/core/error/exceptions.dart';
import 'package:postsapp_clean/features/posts/Data/model/postModel.dart';

import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalData {
  Future<List<Postmodel>> getCashedData();
  Future<Unit> cashPosts(List<Postmodel> postMOdels);
}

class LocalDataImplement implements LocalData {
  final SharedPreferences sharedPreferences;

  LocalDataImplement({required this.sharedPreferences});
  @override
  Future<Unit> cashPosts(List<Postmodel> postMOdels) {
    List PostModelToJson = postMOdels
        .map<Map<String, dynamic>>((postmodel) => postmodel.toJson())
        .toList();
    sharedPreferences.setString("cashedPost", json.encode(PostModelToJson));
    return Future.value(unit);
  }

  @override
  Future<List<Postmodel>> getCashedData() {
    final JsonString = sharedPreferences.getString("cashedPost");
    if (JsonString != null) {
      List DecodeJson = json.decode(JsonString);
      List<Postmodel> JsonToPostmodel = DecodeJson.map<Postmodel>(
        (jsonPostModel) => Postmodel.fromJson(jsonPostModel),
      ).toList();
      return Future.value(JsonToPostmodel);
    } else {
      throw EmptyCashExcption();
    }
  }
}
