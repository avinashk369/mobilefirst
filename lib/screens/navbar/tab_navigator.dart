import 'package:flutter/material.dart';
import 'package:mobilefirst/screens/bookmarks.dart';
import 'package:mobilefirst/screens/home.dart';

class TabNavigator extends StatelessWidget {
  const TabNavigator(
      {Key? key, required this.navigatorKey, required this.tabItem})
      : super(key: key);
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  @override
  Widget build(BuildContext context) {
    late Widget child;
    if (tabItem == "Page1") {
      child = const Home();
    } else if (tabItem == "Page2") {
      child = const BookMarks();
    }
    //else if (tabItem == "Page3") child = Page3();

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
