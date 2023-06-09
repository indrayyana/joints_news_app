// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsLoadedState extends NewsState {
  final List<Article> listNews;
  NewsLoadedState({
    required this.listNews,
  });

  @override
  List<Object?> get props => [listNews];
}
