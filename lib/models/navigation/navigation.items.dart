import 'package:flutter/material.dart';
import 'package:mobilefirst/screens/home.dart';
import 'package:mobilefirst/screens/bookmarks.dart';

class NavigationItems {
  final Widget page;
  final String title;
  final Icon icon;
  final Icon selectedIcon;

  NavigationItems({
    required this.page,
    required this.title,
    required this.icon,
    required this.selectedIcon,
  });

  static List<NavigationItems> get items => [
        NavigationItems(
          page: const Home(),
          icon: const Icon(
            Icons.home_outlined,
            color: Colors.grey,
          ),
          title: "Home",
          selectedIcon: const Icon(
            Icons.home,
            color: Colors.white,
          ),
        ),
        NavigationItems(
          page: const BookMarks(),
          icon: const Icon(
            Icons.bookmark_outline,
            color: Colors.grey,
          ),
          title: "Bookmarks",
          selectedIcon: const Icon(
            Icons.bookmark,
            color: Colors.white,
          ),
        ),
      ];
}
