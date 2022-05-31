import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobilefirst/models/news/article.dart';
import 'package:mobilefirst/styles/styles.dart';

class NewsCard extends StatelessWidget {
  const NewsCard(
      {Key? key,
      required this.articles,
      required this.onTap,
      required this.bookmark})
      : super(key: key);
  final Articles articles;
  final Function(Articles articles) onTap;
  final Function(Articles articles) bookmark;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(articles),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .2,
        child: Card(
          color: Colors.grey[50],
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.height * .2,
                  height: MediaQuery.of(context).size.height * .2,
                  child: Card(
                    elevation: 0,
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: articles.urlToImage ??
                          'https://via.placeholder.com/150',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        articles.title!,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: kLabelStyleBold,
                      ),
                      const Spacer(),
                      Text(articles.source != null
                          ? articles.source!.name!
                          : ""),
                      Text(articles.author ?? "Unknown"),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                IconButton(
                  onPressed: () => bookmark(articles),
                  icon: Icon(articles.status == 1
                      ? Icons.bookmark
                      : Icons.bookmark_outline),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
