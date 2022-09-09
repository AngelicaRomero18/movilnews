// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_print, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:movilnews/common/icons__news_icons.dart';
import 'package:movilnews/models/new_news.dart';
import 'package:movilnews/models/category.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  late List<News> newsList = [];
  late String category = "business";
  late List<Category> categorys = [
    Category.fromJson({
      "title": "Business",
      "icon": Icons_News.business,
      "value": 'business'
    }),
    Category.fromJson({
      "title": "Entertainment",
      "icon": Icons_News.entertainment,
      "value": 'entertainment'
    }),
    Category.fromJson(
        {"title": "General", "icon": Icons_News.general, "value": 'general'}),
    Category.fromJson(
        {"title": "Health", "icon": Icons_News.health, "value": 'health'}),
    Category.fromJson(
        {"title": "Science", "icon": Icons_News.science, "value": 'science'}),
    Category.fromJson(
        {"title": "Sports", "icon": Icons_News.sports, "value": 'sports'}),
    Category.fromJson({
      "title": "Technology",
      "icon": Icons_News.technology,
      "value": 'technology'
    }),
  ];

  @override
  void initState() {
    getNews();
    super.initState();
  }

  changeCategory(String newCategory) {
    setState(() {
      category = newCategory;
    });
    getNews();
  }

  getNews() async {
    print(category);
    Response response = await get(
      Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=de&category=$category&apiKey=0eea4b514b844b70b3ab75845cbf977d'),
    );
    if (response.statusCode == 200) {
      var result = response.body;
      var jsonNews = jsonDecode(result);
      int newsCount = jsonNews['totalResults'];
      var newsRes = jsonNews['articles'];
      List<News> recNews = [];
      for (var index = 0; index < newsRes.length; index++) {
        var news = News.fromJson(newsRes[index]);
        recNews.add(news);
      }
      setState(() {
        newsList = recNews;
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load orders');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 30),
        color: Colors.black,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: DefaultTabController(
            length: 7,
            child: Scaffold(
              body: Center(
                  child: SingleChildScrollView(
                      child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: newsList
                    .map<Widget>((news) => Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        margin: EdgeInsets.only(
                          bottom: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xff3c6997),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  news.author ?? '',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                )),
                            Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  news.title ?? '',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                            Container(
                              child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50),
                                    bottomRight: Radius.circular(50),
                                  ),
                                  child: Image.network(
                                    news.urlToImage ?? '',
                                    fit: BoxFit.cover,
                                    loadingBuilder: (BuildContext ctx,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      } else {
                                        return Center(
                                          heightFactor: 2,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              Color(0xffd7263d),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    errorBuilder: (BuildContext ctx,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      return Container(
                                          alignment: Alignment.center,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Text(
                                            'Your error image...',
                                            style: TextStyle(
                                                color: Color(0xffd7263d),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30),
                                          ));
                                    },
                                  )),
                            ),
                            Container(
                                padding: EdgeInsets.all(10),
                                child: Text(news.description ?? '',
                                    style: TextStyle(color: Colors.white))),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                        alignment: Alignment.center,
                                        height: 40,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: Color(0xffd7263d),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                        ),
                                        child: Icon(Icons_News.star,
                                            size: 25.0, color: Colors.white)),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                        alignment: Alignment.center,
                                        height: 40,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: Color(0xff3f6c51),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                        ),
                                        child: Icon(Icons_News.comment,
                                            size: 25.0, color: Colors.white)),
                                  )
                                ],
                              ),
                            )
                          ],
                        )))
                    .toList(),
              ))),
              bottomNavigationBar: SizedBox(
                  height: 60,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: categorys
                              .map<Widget>((categoryTap) => SizedBox(
                                  height: 50,
                                  width: 100,
                                  child: InkWell(
                                      onTap: () =>
                                          changeCategory(categoryTap.value),
                                      child: Column(children: [
                                        Icon(categoryTap.icon,
                                            size: 25.0,
                                            color: category == categoryTap.value
                                                ? Colors.white
                                                : Colors.grey),
                                        Text(
                                          categoryTap.title,
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ]))))
                              .toList()))),
              backgroundColor: Colors.black,
            )));
  }
}
