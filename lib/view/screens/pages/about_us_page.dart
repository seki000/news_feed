import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: AnimatedContainer(
            alignment: _isSelected ? Alignment.center : Alignment.topCenter,
            width: _isSelected ? 300 : 50,
            height: _isSelected ? 200 : 25,
            child: AutoSizeText(
              "News Feed App",
              style: TextStyle(fontSize: 40.0),
              minFontSize: 6.0,
              maxLines: 1,
              overflow: TextOverflow.visible,
            ),
            duration: Duration(milliseconds: 1000),
            curve: Curves.fastOutSlowIn,
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.play_arrow),
            tooltip: "飛び出すよ",
            onPressed: () {
              _isSelected = !_isSelected;
              setState(() {});
            }),
      ),
    );
  }
}
