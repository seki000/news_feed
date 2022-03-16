import 'package:flutter/material.dart';
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/search_type.dart';
import 'package:news_feed/repository/news_repository.dart';

class NewsListViewModel extends ChangeNotifier{

  final NewsRepository _repository = NewsRepository();

  SearchType _searchType = SearchType.CATEGORY; //外からはアクセスできないようにアンダースコア
  SearchType get searchTypes => _searchType;  //getter経由で値の取得はできる（カプセル化）

  Category _category = categories[0];  //カテゴリー総合
  Category get category => _category;

  String _keyword = "";
  String get keyword => _keyword;

  bool _isLoading = false;  //ロードしているときはロード中のエフェクトあり、してないときはエフェクトなし
  bool get isLoading  => _isLoading;

  Future<void> getNews({required SearchType searchType, String? keyword, Category? category}) async{
    _searchType = searchType;
    _keyword = keyword ?? "";
    _category = category ?? categories[0];

    _isLoading = true;
    notifyListeners();

    print("[ViewModel] searchTypes: $searchType / keyword: $keyword / category: $category");


    await _repository.getNews(searchType: _searchType, keyword: _keyword, category: _category);

    _isLoading = false;
    notifyListeners();

    //TODO
  }


}


