import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_feed/data/search_type.dart';
import 'package:news_feed/models/model/news_models.dart';
import 'package:news_feed/view/compornents/head_line_item.dart';
import 'package:news_feed/view/compornents/page_transformer.dart';
import 'package:news_feed/viewmodels/head_line_viewmodel.dart';
import 'package:provider/provider.dart';

import '../news_webpage_screen.dart';

class HeadLinePage extends StatelessWidget {
  const HeadLinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HeadLineViewModel>(context, listen: false);
    // final viewModel = context.read<HeadLineViewModel>();

    if (!viewModel.isLoading && viewModel.articles.isEmpty) {
      Future(() => viewModel.getHeadLines(searchType: SearchType.HEAD_LINE));
    }

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<HeadLineViewModel>(
            builder: (context, model, child) {
              if (model.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return PageTransformer(
                  pageViewBuilder: (context, pageVisibilityResolver) {
                    return PageView.builder(
                        controller:
                            PageController(viewportFraction: 0.9 //左右のサイズ 1.0が最大
                                ),
                        itemCount: model.articles.length,
                        itemBuilder: (context, index) {
                          final article = model.articles[index];
                          final pageVisibility = pageVisibilityResolver
                              .resolvePageVisibility(index);
                          final visibleFraction =
                              pageVisibility.visibleFraction;
                          return HeadLineItem(
                              article: model.articles[index],
                              pageVisibility: pageVisibility,
                              onArticleClicked: (article) =>
                                  _openArticleWebPage(article, context));
                        });
                  },
                );
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            onRefresh(context);
          },
          child: Icon(Icons.refresh),
        ),
      ),
    );
  }

  //TODO 更新処理
  void onRefresh(BuildContext context) async {
    print("HeadlinePage.onRefresh");
    final viewModel = Provider.of<HeadLineViewModel>(context, listen: false);
    // final viewModel = context.read<HeadLineViewModel>();
    await viewModel.getHeadLines(searchType: SearchType.HEAD_LINE);
  }

  _openArticleWebPage(Article article, BuildContext context) {
    print("HeadlinePage._openArticleWebPage: ${article.url}");
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => NewsWebPageScreen(article: article)));
  }
}
