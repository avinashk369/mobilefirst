import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilefirst/blocs/news/newsbloc.dart';
import 'package:mobilefirst/models/news/article.dart';
import 'package:mobilefirst/routes/route_constants.dart';
import 'news_card.dart';
import 'news_detail.dart';

class BookmarkNewsList extends StatelessWidget {
  const BookmarkNewsList({
    Key? key,
    required this.articles,
  }) : super(key: key);
  final List<Articles> articles;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return NewsCard(
          articles: articles[index],
          onTap: (article) {
            //Navigator.of(context).pushNamed(newsDetail, arguments: article);
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
                  BookmarkNews(article: article),
                );
          },
        );
      },
      itemCount: articles.length,
    );
  }
}
