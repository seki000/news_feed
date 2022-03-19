import 'package:flutter/material.dart';

import '../data/search_type.dart';
import '../models/model/news_models.dart';
import '../repository/news_repository.dart';

class HeadLineViewModel extends ChangeNotifier{
  final NewsRepository _repository = NewsRepository();

  SearchType _searchType = SearchType.CATEGORY; //外からはアクセスできないようにアンダースコア
  SearchType get searchTypes => _searchType; //getter経由で値の取得はできる（カプセル化）

  bool _isLoading = false; //ロードしているときはロード中のエフェクトあり、してないときはエフェクトなし
  bool get isLoading => _isLoading;

  List<Article> _articles = [];
  List<Article> get articles => _articles;

  Future<void> getHeadLines({required SearchType searchType}) async{
    _searchType = searchType;
    _isLoading = true;
    notifyListeners();

    _articles = await _repository.getNews(searchType: SearchType.HEAD_LINE);
    print("searchType: $_searchType /  articles: ${_articles[0].title}");
    _isLoading = false;
    notifyListeners();
  }


}