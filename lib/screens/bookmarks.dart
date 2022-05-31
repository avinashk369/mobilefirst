library user_settings;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilefirst/blocs/bookmark/bookmarkbolc.dart';
import 'package:mobilefirst/blocs/news/newsbloc.dart';
import 'package:mobilefirst/repository/news_repositoryImpl.dart';
import 'package:mobilefirst/screens/news/boomark_news_list.dart';
import 'package:mobilefirst/styles/styles.dart';
import 'package:mobilefirst/utils/theme_constants.dart';
import 'package:mobilefirst/widgets/custom_appbar.dart';
import 'package:mobilefirst/widgets/loading_ui.dart';

class BookMarks extends StatelessWidget {
  const BookMarks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookmarkBloc(
        context.read<NewsRepositoryImpl>(),
      )..add(const LoadBookMarkNews()),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: kToolbarHeight,
              automaticallyImplyLeading: false,
              floating: true,
              pinned: true,
              snap: false,
              elevation: 0,
              actions: [
                Builder(builder: (context) {
                  return IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      context
                          .read<BookmarkBloc>()
                          .add(const LoadBookMarkNews());
                    },
                  );
                }),
              ],
              flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Column(
                    children: const [
                      CustomAppBar(
                        title: 'Bookmarks',
                      ),
                    ],
                  )),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(height: 20),
                  BlocBuilder<BookmarkBloc, BookmarkState>(
                    builder: (context, state) {
                      if (state is BookmarkNewsLoaded) {
                        return BookmarkNewsList(
                          articles: state.articles,
                        );
                      }
                      if (state is NewsInitializing) {
                        return const LoadingUI();
                      }
                      if (state is BookmarkError) {
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

  Widget listTileCard(String title, Function() onTap, Widget child) => InkWell(
        onTap: onTap,
        child: Card(
          elevation: 0,
          color: Colors.grey[50],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: child,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  title,
                  style: kLabelStyleBold.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      );
}
