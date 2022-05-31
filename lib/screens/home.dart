import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilefirst/blocs/news/newsbloc.dart';
import 'package:mobilefirst/screens/news/news_list.dart';
import 'package:mobilefirst/styles/styles.dart';
import 'package:mobilefirst/utils/preference_utils.dart';
import 'package:mobilefirst/utils/theme_constants.dart';
import 'package:mobilefirst/utils/utils.dart';
import 'package:mobilefirst/widgets/custom_appbar.dart';
import 'package:mobilefirst/widgets/loading_ui.dart';
import 'package:mobilefirst/widgets/search_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key, this.user}) : super(key: key);
  final User? user;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ScrollController scrollController;

  bool isSearching = false;
  bool reachedEnd = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (isScrollAtBottom() && !reachedEnd) {
      context.read<NewsBloc>().add(const LoadNews(isSearching: false));
    }
  }

  bool isScrollAtBottom() {
    if (scrollController.position.atEdge) {
      return scrollController.position.pixels != 0;
    }
    return false;
  }

  @override
  void dispose() {
    scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverAppBar(
              expandedHeight: kToolbarHeight * 2,
              automaticallyImplyLeading: false,
              floating: true,
              pinned: true,
              snap: false,
              elevation: 0,
              bottom: SearchBar(
                onSearch: ((searchText) {
                  isSearching = true;
                  context.read<NewsBloc>().add(
                        LoadNews(
                          name: searchText.trim(),
                          isSearching: isSearching,
                        ),
                      );
                }),
              ),
              flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Column(
                    children: [
                      CustomAppBar(
                        title: "Hi, ${PreferenceUtils.getString(userName)}",
                      ),
                    ],
                  )),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  BlocBuilder<NewsBloc, NewsState>(
                    builder: (context, state) {
                      if (state is NewsLoaded) {
                        reachedEnd = state.hasReachedMax;
                        return NewsList(
                          articles: state.articles,
                          hasReachedMax: reachedEnd,
                        );
                      }
                      if (state is NewsInitializing) {
                        return const LoadingUI();
                      }
                      if (state is NewsError) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            state.message,
                            textAlign: TextAlign.center,
                            style: kLabelStyleBold.copyWith(color: redColor),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
