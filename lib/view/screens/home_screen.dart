import 'package:flutter/material.dart';
import 'package:news_feed/view/screens/pages/about_us_page.dart';
import 'package:news_feed/view/screens/pages/headline_page.dart';
import 'package:news_feed/view/screens/pages/news_list_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final _pages = [
    NewsListPage(),
    HeadLinePage(),
    AboutUsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
              label: "トップニュース",
              icon: const Icon(Icons.highlight),
            ),
            BottomNavigationBarItem(
              label: "ニュース一覧",
              icon: const Icon(Icons.list),
            ),
            BottomNavigationBarItem(
              label: "このアプリについて",
              icon: const Icon(Icons.info),
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
