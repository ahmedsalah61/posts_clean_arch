import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../model/postModel.dart';

abstract class RemoteData {
  Future<List<Postmodel>> GetAllPosts();
  Future<Unit> DeletePost(int postId);
  Future<Unit> updatePost(Postmodel postModel);
  Future<Unit> addPost(Postmodel postModel);
}

const BASE_URL = "https://jsonplaceholder.typicode.com";

class RemoteDataImplemnet implements RemoteData {
  final http.Client client;

  RemoteDataImplemnet({required this.client});
  @override
  @override
  Future<List<Postmodel>> GetAllPosts() async {
    final response = await client.get(
      Uri.parse("$BASE_URL/posts/"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      final List decodeJson = json.decode(response.body) as List;
      final List<Postmodel> postMOdels = decodeJson
          .map<Postmodel>((jsonPOstMOdel) => Postmodel.fromJson(jsonPOstMOdel))
          .toList();
      return postMOdels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(Postmodel postModel) async {
    final body = {"body": postModel.body, "title": postModel.title};
    final response = await client.post(
      Uri.parse("$BASE_URL/posts/"),
      body: body,
    );
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> DeletePost(int postId) async {
    final response = await client.delete(
      Uri.parse("$BASE_URL/posts/${postId.toString()}"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(Postmodel postModel) async {
    final postId = postModel.id.toString();
    final body = {"title": postModel.title, "body": postModel.body};
    final response = await client.patch(
      Uri.parse("$BASE_URL/posts/$postId"),
      body: body,
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
