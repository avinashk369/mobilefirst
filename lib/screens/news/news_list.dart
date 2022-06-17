import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilefirst/blocs/news/newsbloc.dart';
import 'package:mobilefirst/models/news/article.dart';
import 'package:mobilefirst/widgets/loading_ui.dart';
import 'news_card.dart';
import 'news_detail.dart';

class NewsList extends StatelessWidget {
  const NewsList(
      {Key? key, required this.articles, required this.hasReachedMax})
      : super(key: key);
  final List<Articles> articles;
  final bool hasReachedMax;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return index >= articles.length
            ? const LoadingUI()
            : NewsCard(
                articles: articles[index],
                onTap: (article) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => NewsDetail(
                        articles: article,
                      ),
                    ),
                  );
                },
                bookmark: (article) {
                  context.read<NewsBloc>().add(
                        BookmarkNews(article: article.copyWith(status: 1)),
                      );
                },
              );
      },
      itemCount: articles.length + (hasReachedMax ? 0 : 1),
    );
  }
}
