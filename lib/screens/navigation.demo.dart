import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilefirst/blocs/news/newsbloc.dart';
import 'package:mobilefirst/blocs/navigation/navigation.bloc.dart';
import 'package:mobilefirst/models/navigation/navigation.items.dart';
import 'package:mobilefirst/repository/news_repositoryImpl.dart';

class NavigationDemo extends StatelessWidget {
  const NavigationDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationBloc>(
          create: (context) => NavigationBloc(),
        ),
        BlocProvider<NewsBloc>(
          create: (context) => NewsBloc(
            context.read<NewsRepositoryImpl>(),
          )..add(
              const LoadNews(isSearching: false),
            ),
        ),
      ],
      child: Scaffold(
        //extendBody: true,
        body: BlocBuilder<NavigationBloc, int>(
          builder: (context, state) {
            return IndexedStack(
              index: state,
              children: NavigationItems.items.map((e) => e.page).toList(),
            );
          },
        ),
        bottomNavigationBar: BlocBuilder<NavigationBloc, int>(
          builder: (context, state) {
            return ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5.0),
                topRight: Radius.circular(5.0),
              ),
              child: NavigationBarTheme(
                data: NavigationBarThemeData(
                  indicatorColor: Colors.deepPurpleAccent,
                  labelTextStyle: MaterialStateProperty.all(
                    const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
                child: NavigationBar(
                  backgroundColor: Colors.grey[100],
                  height: 60,
                  labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                  selectedIndex: state,
                  animationDuration: const Duration(seconds: 1),
                  onDestinationSelected: (int index) {
                    context.read<NavigationBloc>().changeNavigation(index);
                  },
                  destinations: NavigationItems.items.map((item) {
                    return NavigationDestination(
                      icon: item.icon,
                      label: item.title,
                      selectedIcon: item.selectedIcon,
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
