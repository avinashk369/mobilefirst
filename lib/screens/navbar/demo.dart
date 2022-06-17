import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilefirst/blocs/navigation/nav_bloc.dart';
import 'package:mobilefirst/models/todo_model.dart';
import 'package:mobilefirst/repository/news_repositoryImpl.dart';

import '../../blocs/news/newsbloc.dart';
import 'tab_navigator.dart';

List<String> pageKeys = ["Page1", "Page2"];
final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
  "Page1": GlobalKey<NavigatorState>(),
  "Page2": GlobalKey<NavigatorState>()
};

class Demo extends StatelessWidget {
  const Demo({Key? key, required this.navBloc}) : super(key: key);
  final NavBloc navBloc;

  // persistent bottom navigation bar

  void _selectTab(String tabItem, int index) {
    if (tabItem == navBloc.state.name) {
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      navBloc.changeNavigation(tabItem, index);
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
      child: BlocBuilder<NavBloc, TodoModel>(
          bloc: navBloc,
          builder: (context, state) {
            return WillPopScope(
              onWillPop: () async {
                final isFirstRouteInCurrentTab =
                    !await _navigatorKeys[state.name]!.currentState!.maybePop();
                if (isFirstRouteInCurrentTab) {
                  if (state.name != "Page1") {
                    _selectTab("Page1", 1);

                    return false;
                  }
                }
                // let system handle back button if we're on the first route
                return isFirstRouteInCurrentTab;
              },
              child: Scaffold(
                body: Stack(
                  children:
                      pages.map((e) => _buildOffstageNavigator(e)).toList(),
                ),
                bottomNavigationBar: BlocBuilder<NavBloc, TodoModel>(
                    bloc: navBloc,
                    builder: (context, state) {
                      return SizedBox(
                        child: BottomNavigationBar(
                          type: BottomNavigationBarType.fixed,
                          currentIndex: state.carbs!,
                          onTap: (index) => _selectTab(pageKeys[index], index),
                          showSelectedLabels: false,
                          showUnselectedLabels: false,
                          selectedIconTheme:
                              const IconThemeData(color: Colors.blue),
                          items: <BottomNavigationBarItem>[
                            BottomNavigationBarItem(
                              icon: Column(
                                children: [
                                  const Icon(Icons.home),
                                  const Text("Home"),
                                  state.carbs == 0 ? indicator() : Container()
                                ],
                              ),
                              label: 'Home',
                            ),
                            BottomNavigationBarItem(
                              icon: Column(
                                children: [
                                  const Icon(Icons.bookmark),
                                  const Text("Bookmarks"),
                                  state.carbs == 1 ? indicator() : Container(),
                                ],
                              ),
                              label: 'Bookmarks',
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            );
          }),
    );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: navBloc.state.name != tabItem,
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
