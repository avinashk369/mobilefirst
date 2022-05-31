part of 'news_bloc.dart';

@immutable
abstract class NewsState extends Equatable {
  const NewsState();
}

class NewsInitializing extends NewsState {
  @override
  List<Object> get props => [];
}

class NewsLoading extends NewsState {
  @override
  List<Object> get props => [];
}

class Loading extends NewsState {
  final List<NewsModel> news;
  const Loading({
    required this.news,
  });
  @override
  List<Object> get props => [];
}

class NewsError extends NewsState {
  String message;
  NewsError({required this.message});
  @override
  List<Object> get props => [message];
}

class NewsLoaded extends NewsState {
  final List<Articles> articles;
  final bool hasReachedMax;
  const NewsLoaded({
    required this.articles,
    this.hasReachedMax = false,
  });

// this  copy with is used to copy the state and add the new data
  NewsLoaded copyWith({
    List<Articles>? articles,
    bool? hasReachedMax,
  }) {
    return NewsLoaded(
      articles: articles ?? this.articles,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [articles, hasReachedMax];
}

class NewsBookmarked extends NewsState {
  final Articles articles;

  const NewsBookmarked({required this.articles});

  @override
  List<Object> get props => [articles];
}

class BookmarkNewsLoaded extends NewsState {
  final List<Articles> articles;

  const BookmarkNewsLoaded({
    required this.articles,
  });

  @override
  List<Object> get props => [articles];
}
