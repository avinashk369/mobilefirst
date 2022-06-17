import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilefirst/blocs/navigation/navigation.bloc.dart';
import 'package:mobilefirst/repository/news_repositoryImpl.dart';

import '../../blocs/news/newsbloc.dart';
import 'tab_navigator.dart';

class Demo extends StatefulWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  // persistent bottom navigation bar
  String _currentPage = "Page1";
  List<String> pageKeys = ["Page1", "Page2"];
  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Page1": GlobalKey<NavigatorState>(),
    "Page2": GlobalKey<NavigatorState>()
  };
  int _selectedIndex = 0;

  void _selectTab(String tabItem, int index) {
    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  static const pages = ['Page1', 'Page2'];
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsBloc>(
          create: (context) => NewsBloc(
            context.read<NewsRepositoryImpl>(),
          )..add(
              const LoadNews(isSearching: false),
            ),
        ),
      ],
      child: WillPopScope(
        onWillPop: () async {
          final isFirstRouteInCurrentTab =
              !await _navigatorKeys[_currentPage]!.currentState!.maybePop();
          if (isFirstRouteInCurrentTab) {
            if (_currentPage != "Page1") {
              _selectTab("Page1", 1);

              return false;
            }
          }
          // let system handle back button if we're on the first route
          return isFirstRouteInCurrentTab;
        },
        child: Scaffold(
          body: Stack(
            children: pages.map((e) => _buildOffstageNavigator(e)).toList(),
          ),
          bottomNavigationBar: SizedBox(
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              onTap: (index) => _selectTab(pageKeys[index], index),
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedIconTheme: const IconThemeData(color: Colors.blue),
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      const Icon(Icons.call),
                      const Text("Calls"),
                      _selectedIndex == 0 ? indicator() : Container()
                    ],
                  ),
                  label: 'Calls',
                ),
                BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      const Icon(Icons.camera),
                      const Text("Camera"),
                      _selectedIndex == 1 ? indicator() : Container(),
                    ],
                  ),
                  label: 'Camera',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }

  Widget indicator() => Container(
        height: 3,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(5),
        ),
      );
}
