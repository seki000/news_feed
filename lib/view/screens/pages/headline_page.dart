import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_feed/data/search_type.dart';
import 'package:news_feed/viewmodels/head_line_viewmodel.dart';
import 'package:provider/provider.dart';

class HeadLinePage extends StatelessWidget {
  const HeadLinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final viewModel = Provider.of<HeadLineViewModel>(context, listen: false);
    // final viewModel = context.read<HeadLineViewModel>();

    if(!viewModel.isLoading && viewModel.articles.isEmpty){
      Future (()=> viewModel.getHeadLines(searchType: SearchType.HEAD_LINE));

    }

    return SafeArea(
      child: Scaffold(
        body: Consumer<HeadLineViewModel>(
              builder: (context, model, child){
                return PageView.builder(
                    controller: PageController(),
                    itemCount: model.articles.length,
                    itemBuilder: (context, index){
                      final article = model.articles[index];
                      return Container(
                        color: Colors.red,
                        child: Column(
                          children: [
                            Text(article.title ?? ""),
                            Text(article.description ?? ""),
                          ],
                        ),
                      );
                    });
              },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            onRefresh(context);
          },
          child: Icon(Icons.refresh),
        ),
      ),
    );
  }

  //TODO 更新処理
  void onRefresh(BuildContext context) async{
    print("HeadlinePage.onRefresh");
    final viewModel = Provider.of<HeadLineViewModel>(context, listen: false);
    // final viewModel = context.read<HeadLineViewModel>();
    await viewModel.getHeadLines(searchType: SearchType.HEAD_LINE);
  }
}
