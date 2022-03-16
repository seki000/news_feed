import 'package:flutter/material.dart';

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
              //TODO 検索バー
              SearchBar(onSearch: (keyword) => getKeywordNews(context, keyword),),
              //TODO カテゴリー
              // CategoryChips(),
              //TODO 記事表示
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
  void onRefresh(BuildContext context) {}

  //TODO キーワード記事取得処理
  getKeywordNews(BuildContext context, keyword) {
    print("NewListPage.getKeywordNews");
  }
}
