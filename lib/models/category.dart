import 'package:flutter/cupertino.dart';

class Category {
  String title;
  IconData icon;
  String value;

  Category.fromJson(Map json)
      : title = json['title'],
        icon = json['icon'],
        value = json['value'];

  Map toJson() {
    return {'title': title, 'icon': icon, 'value': value};
  }
}
