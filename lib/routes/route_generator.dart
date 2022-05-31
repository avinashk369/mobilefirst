import 'package:flutter/material.dart';
import 'package:mobilefirst/models/news/article.dart';

import 'package:mobilefirst/screens/navigation.demo.dart';
import 'package:mobilefirst/screens/news/news_detail.dart';
import 'package:mobilefirst/utils/slide_right_route.dart';

import 'route_constants.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case homeRoute:
        return SlideRightRoute(page: const NavigationDemo());
      case newsDetail:
        return SlideRightRoute(
            page: NewsDetail(
          articles: args as Articles,
        ));

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
