import 'dart:convert';

import 'package:haber_uygulamasi/models/article.dart';
import 'package:http/http.dart' as http;

import '../models/news.dart';

class NewsService {
  static NewsService _singleton = NewsService._internal();
  NewsService._internal();

  factory NewsService() {
    return _singleton;
  }

  static Future<List<Articles>?> getNews() async {
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=tr&category=business&apiKey=04e92ff517274cb38a80c3464852ab55");
    final response = await http.get(url);
    if (response.body.isNotEmpty) {
      final responseJson = json.decode(response.body);
      News news = News.fromJson(responseJson);
      return news.articles;
    }
    return null;
  }
}
