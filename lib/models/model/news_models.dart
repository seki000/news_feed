import 'package:json_annotation/json_annotation.dart';

part 'news_models.g.dart';

//https://docs.flutter.dev/development/data-and-backend/json#creating-model-classes-the-json_serializable-way
//https://newsapi.org/

@JsonSerializable()
class News {
  final List<Article> articles;
  News({required this.articles});

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);
  Map<String, dynamic> toJson() => _$NewsToJson(this);
}

@JsonSerializable() //これがないとコード生成してくれない
class Article {
  final String?  title;
  final String? description;
  final String?  url;
  final String?  urlToImage;
  @JsonKey(name: "publishedAt") final String? publishDate; //publishedAtをpublishDateとして扱う処理
  final String?  content;

  Article({this.title, this.description, this.url, this.urlToImage,  this.publishDate,  this.content});

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleToJson(this);

}