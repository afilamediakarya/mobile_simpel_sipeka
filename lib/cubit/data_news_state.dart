part of 'data_news_cubit.dart';

abstract class DataNewsState extends Equatable {
  const DataNewsState();

  @override
  List<Object> get props => [];
}

class DataNewsInitial extends DataNewsState {}

class DataNewsLoading extends DataNewsState {}

class DataNewsSuccess extends DataNewsState {
  final List<DataNews> dataNews;

  const DataNewsSuccess(
    this.dataNews,
  );

  @override
  List<Object> get props => [dataNews];
}

class DataNewsFailed extends DataNewsState {
  final String error;

  const DataNewsFailed(this.error);

  @override
  List<Object> get props => [error];
}
