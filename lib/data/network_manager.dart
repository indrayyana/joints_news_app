import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project/data/article_model.dart';

class NetworkManager {
  Future<List<Article>> getAllNews() async {
    try {
      final response = await http.get(Uri.parse(
          "https://newsapi.org/v2/top-headlines?country=id&category=business&apiKey=8210845320fd451c9e6d94f3ba0fe39f"));

      return ArticleModel.fromJson(json.decode(response.body)).articles!;
    } catch (e) {
      throw Exception(
          'Failed to connect to the server. Please check your internet connection');
    }
  }

  Future<List<Article>> getSearchNews(String search) async {
    final response = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=id&category=business&apiKey=8210845320fd451c9e6d94f3ba0fe39f&q=$search"));

    return ArticleModel.fromJson(json.decode(response.body)).articles!;
  }
}
