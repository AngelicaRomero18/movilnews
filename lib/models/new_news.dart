import 'package:flutter/cupertino.dart';

class News {
  String? author;
  String? title;
  String? urlToImage;
  String? description;

  News.fromJson(Map json)
      : author = json['author'],
        title = json['title'],
        description = json['description'],
        urlToImage = json['urlToImage'];

  Map toJson() {
    return {
      'author': author,
      'title': title,
      'description': description,
      'urlToImage': urlToImage
    };
  }
}
