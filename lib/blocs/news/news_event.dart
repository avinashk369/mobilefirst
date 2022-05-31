part of 'news_bloc.dart';

@immutable
abstract class NewsEvent extends Equatable {
  const NewsEvent();
}

class LoadNews extends NewsEvent {
  final String? name;
  final bool isSearching;
  const LoadNews({
    this.name,
    this.isSearching = false,
  });
  @override
  List<Object> get props => [];
}

class BookmarkNews extends NewsEvent {
  final Articles article;
  const BookmarkNews({
    required this.article,
  });
  @override
  List<Object> get props => [];
}

class LoadBookMarkNews extends NewsEvent {
  const LoadBookMarkNews();
  @override
  List<Object> get props => [];
}
