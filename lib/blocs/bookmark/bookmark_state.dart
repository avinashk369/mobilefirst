part of 'bookmark_bloc.dart';

@immutable
abstract class BookmarkState extends Equatable {
  const BookmarkState();
}

class BookmarkInitializing extends BookmarkState {
  @override
  List<Object> get props => [];
}

class BookmarkError extends BookmarkState {
  String message;
  BookmarkError({required this.message});
  @override
  List<Object> get props => [message];
}

class BookmarkNewsLoaded extends BookmarkState {
  final List<Articles> articles;

  const BookmarkNewsLoaded({
    required this.articles,
  });

  @override
  List<Object> get props => [articles];
}
