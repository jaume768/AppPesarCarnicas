import 'article.dart';

class Client {
  final int code;
  final String name;
  final List<Article> articles;

  Client({required this.code, required this.name, required this.articles});

  factory Client.fromJson(Map<String, dynamic> json) {
    var list = json['articles'] as List;
    List<Article> articlesList = list.map((i) => Article.fromJson(i)).toList();
    return Client(
      code: json['code'],
      name: json['name'],
      articles: articlesList,
    );
  }
}
