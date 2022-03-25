import 'package:flutter/material.dart';
import 'package:news_feed/models/db/database.dart';
import 'package:news_feed/styles/styles.dart';
import 'package:news_feed/view/screens/home_screen.dart';
import 'package:news_feed/viewmodels/head_line_viewmodel.dart';
import 'package:news_feed/viewmodels/news_list_viewmodel.dart';
import 'package:provider/provider.dart';


late MyDatabase myDatabase;

void main(){
  myDatabase = MyDatabase();
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => NewsListViewModel()
          ),
          ChangeNotifierProvider(
              create: (_) => HeadLineViewModel()
          ),
        ],
            child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "NewsFeed",
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: BoldFont,
      ),
      home: HomeScreen(),

    );
  }
}
