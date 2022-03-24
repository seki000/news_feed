import 'package:flutter/material.dart';
import 'package:news_feed/view/compornents/page_transformer.dart';

class LazyLoadText extends StatelessWidget {
  final PageVisibility pageVisibility;
  final String text;

  const LazyLoadText({required this.pageVisibility, required this.text});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.headline6;
    return Opacity(
        opacity: pageVisibility.visibleFraction,
        child: Transform(
          alignment: Alignment.topLeft,
          transform: Matrix4.translationValues(
              pageVisibility.pagePosition * 200, 0.0, 0.0),
          child: Text(
            text,
            style: textTheme?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ));
  }
}
