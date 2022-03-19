import 'package:flutter/material.dart';
import 'package:news_feed/models/model/news_models.dart';
import 'package:news_feed/view/compornents/article_tile_desc.dart';
import 'package:news_feed/view/compornents/image_from_url.dart';

class ArticleTile extends StatelessWidget {
  final Article article;
  final ValueChanged onArticleClicked;

  const ArticleTile({
    Key? key,
    required this.article,
    required this.onArticleClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () => onArticleClicked(article),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 1,
                  //TODO
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ImageFromUrl(
                      imageUrl: article.urlToImage,
                    ),
                  )),
              Expanded(
                flex: 3,
                //TODO
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ArticleTileDesc(article: article),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
