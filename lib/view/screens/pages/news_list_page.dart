import 'package:flutter/material.dart';
import 'package:news_feed/data/search_type.dart';
import 'package:news_feed/view/compornents/category_chips.dart';
import 'package:news_feed/viewmodels/news_list_viewmodels.dart';
import 'package:provider/provider.dart';

import '../../../data/category_info.dart';
import '../../compornents/serach_bar.dart';

class NewsListPage extends StatelessWidget {
  const NewsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          tooltip: "更新",
          onPressed: () {
            onRefresh(context);
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SearchBar(
                onSearch: (keyword) => getKeywordNews(context, keyword),
              ),
              //TODO カテゴリー
              CategoryChips(
                  onCategorySelected: (category) =>
                      getCategoryNews(context, category)),
              Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //TODO 記事更新処理
  Future<void> onRefresh(BuildContext context) async{
    final viewModel = Provider.of<NewsListViewModel>(context, listen: false);
   await viewModel.getNews(
        searchType: viewModel.searchTypes,
        keyword: viewModel.keyword,
        category: viewModel.category);
  }

  //TODO キーワード記事取得処理
  Future<void> getKeywordNews(BuildContext context, keyword) async{
    final viewModel = Provider.of<NewsListViewModel>(context, listen: false);
    await viewModel.getNews(
        searchType: SearchType.KEYWORD,
        keyword: keyword,
        category: categories[0]);
    print("NewListPage.getKeywordNews");
  }

  //TODO カテゴリー記事取得処理
  Future<void> getCategoryNews(BuildContext context, Category category) async{
    print("NewListPage.getCategoryNews / category: ${category.nameJp}");
    final viewModel = Provider.of<NewsListViewModel>(context, listen: false);
    await viewModel.getNews(searchType: SearchType.CATEGORY, category: category);
  }
}
