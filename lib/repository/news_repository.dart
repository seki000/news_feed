import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_feed/main.dart';
import '../data/category_info.dart';
import '../data/search_type.dart';
import '../models/model/news_models.dart';
import 'package:news_feed/util/extensions.dart';

class NewsRepository {
  static const BASE_URL = "https://newsapi.org/v2/top-headlines?country=jp";
  static const API_KEY = "54eb77a3fccd43af95e7955d4cbc8f3c";

  Future<List<Article>> getNews(
      {required SearchType searchType,
      String? keyword,
      Category? category}) async {
    List<Article> results = [];
    http.Response? response;

    switch (searchType) {
      case SearchType.HEAD_LINE:
        final requestUrl = Uri.parse(BASE_URL + "&apiKey=$API_KEY");
        response = await http.get(requestUrl);
        break;
      case SearchType.KEYWORD:
        final requestUrl =
            Uri.parse(BASE_URL + "&q=$keyword&pageSize=30&apiKey=$API_KEY");
        response = await http.get(requestUrl);
        break;
      case SearchType.CATEGORY:
        final requestUrl = Uri.parse(
            BASE_URL + "&category=${category?.nameEn}&apiKey=$API_KEY");
        response = await http.get(requestUrl);
        break;
    }
    if (response.statusCode == 200) {
      final responseBody = response.body;
      results = await insertAndReadFromDB(jsonDecode(responseBody));
      // results = News.fromJson(jsonDecode(responseBody)).articles;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load News');
    }
    return results;
  }

  Future<List<Article>> insertAndReadFromDB(responseBody) async {
    final dao = myDatabase.newsDao;
    final articles = News.fromJson(responseBody).articles;

    //TODO Webから取得した記事リスト（Dartのモデルクラス：Article）をDBのテーブルクラス（Articles）に変換してDB登録
    final articleRecords =
        await dao.insertAndReadNewsFromDB(articles.toArticleRecords(articles));

    //TODO DBから取得したデータをモデルクラスに変換して返す
    return articleRecords.toArticles(articleRecords);
  }
}
