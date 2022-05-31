part of 'bookmark_bloc.dart';

@immutable
abstract class BookMarkEvent extends Equatable {
  const BookMarkEvent();
}

class BookmarkNews extends BookMarkEvent {
  final Articles article;
  const BookmarkNews({
    required this.article,
  });
  @override
  List<Object> get props => [];
}

class LoadBookMarkNews extends BookMarkEvent {
  const LoadBookMarkNews();
  @override
  List<Object> get props => [];
}
