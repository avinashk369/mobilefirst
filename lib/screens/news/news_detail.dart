import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilefirst/models/news/article.dart';
import 'package:mobilefirst/models/news/news_model.dart';
import 'package:mobilefirst/repository/news_repositoryImpl.dart';
import 'package:mobilefirst/styles/styles.dart';
import 'package:mobilefirst/utils/theme_constants.dart';

import '../../blocs/news/newsbloc.dart';

class NewsDetail extends StatefulWidget {
  const NewsDetail({Key? key, required this.articles}) : super(key: key);
  final Articles articles;

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  late ScrollController _controller;
  bool silverCollapsed = false;
  String myTitle = "";
  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.offset > MediaQuery.of(context).size.height * .2 &&
          !_controller.position.outOfRange) {
        if (!silverCollapsed) {
          setState(() {
            myTitle = widget.articles.author!;
            silverCollapsed = true;
          });
        }
      }
      if (_controller.offset <= MediaQuery.of(context).size.height * .2 &&
          !_controller.position.outOfRange) {
        if (silverCollapsed) {
          setState(() {
            myTitle = "";
            silverCollapsed = false;
          });
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc(context.read<NewsRepositoryImpl>()),
      child: Scaffold(
        body: CustomScrollView(
          controller: _controller,
          slivers: [
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height * .28,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  myTitle,
                  style: kLabelStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
                collapseMode: CollapseMode.pin,
                background: CachedNetworkImage(
                  imageUrl: widget.articles.urlToImage ??
                      "https://via.placeholder.com/150",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      widget.articles.title!,
                      style: kLabelStyleBold.copyWith(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      widget.articles.description ?? "",
                      style: kLabelStyle,
                    ),
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
