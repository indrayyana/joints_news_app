// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'news_bloc.dart';

abstract class NewsEvent {}

class NewsGetEvent extends NewsEvent {}

class NewsSearchEvent extends NewsEvent {
  final String search;
  NewsSearchEvent({
    required this.search,
  });
}
