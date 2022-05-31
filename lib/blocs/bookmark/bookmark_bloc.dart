import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobilefirst/models/news/article.dart';
import 'package:mobilefirst/repository/news_repositoryImpl.dart';
part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookMarkEvent, BookmarkState> {
  final NewsRepositoryImpl _newsRepositoryImpl;

  BookmarkBloc(this._newsRepositoryImpl) : super(BookmarkInitializing()) {
    on<LoadBookMarkNews>(
      (event, emit) => _loadBookmarkNews(event, emit),
    );
  }
  // load bookmar news
  Future _loadBookmarkNews(
      LoadBookMarkNews event, Emitter<BookmarkState> emit) async {
    try {
      final List<Articles> articles =
          await _newsRepositoryImpl.getBookmarkNews();

      emit(BookmarkNewsLoaded(articles: articles));
    } catch (e) {
      emit(BookmarkError(message: "Something went wrong"));
    }
  }
}
