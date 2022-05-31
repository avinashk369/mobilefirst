import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobilefirst/models/ServerError.dart';
import 'package:mobilefirst/models/news/article.dart';
import 'package:mobilefirst/models/news/news_model.dart';
import 'package:mobilefirst/repository/news_repositoryImpl.dart';
import 'package:mobilefirst/utils/utils.dart';
part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepositoryImpl _newsRepositoryImpl;

  NewsBloc(this._newsRepositoryImpl) : super(NewsInitializing()) {
    on<LoadNews>((event, emit) => _loadNews(event, emit));
    on<BookmarkNews>((event, emit) => _bookMarkNews(event, emit));
  }

// bookmark news
  Future _bookMarkNews(BookmarkNews event, Emitter<NewsState> emit) async {
    try {
      final state = this.state;
      await _newsRepositoryImpl.bookmarkNews(event.article);
      if (state is NewsLoaded) {
        List<Articles> articles = state.articles
            .map((article) =>
                article.title == event.article.title ? event.article : article)
            .toList();
        emit(NewsLoaded(articles: articles, hasReachedMax: true));
      }
    } catch (e) {
      print("error in bookmark news");
      emit(NewsError(message: e.toString()));
    }
  }

  int page = 1;
  //load news
  Future _loadNews(LoadNews event, Emitter<NewsState> emit) async {
    try {
      final state = this.state;
      // load search string data
      if (event.isSearching) {
        NewsModel newsModel =
            await _newsRepositoryImpl.loadNews(page, 10, event.name);
        newsModel.articles!.isEmpty
            ? emit(NewsError(message: noData))
            : emit(
                NewsLoaded(articles: newsModel.articles!, hasReachedMax: true));
        return;
      }
      // load first page data
      if (state is NewsInitializing) {
        NewsModel news =
            await _newsRepositoryImpl.loadNews(page, 10, event.name);
        emit(NewsLoaded(articles: news.articles!, hasReachedMax: false));
      }
      // load data as you scroll till you reach end
      if (state is NewsLoaded) {
        NewsModel news =
            await _newsRepositoryImpl.loadNews(++page, 10, event.name);
        emit(
          news.articles!.length < 10
              ? (state).copyWith(hasReachedMax: true)
              : NewsLoaded(
                  articles: [...state.articles, ...news.articles!],
                  hasReachedMax: false,
                ),
        );
      }
    } on ServerError catch (e) {
      print(e.getErrorMessage());
      emit(NewsError(message: e.getErrorMessage()));
    } catch (e, stacktrace) {
      print(stacktrace.toString());
      emit(NewsError(message: e.toString()));
    }
  }
}
