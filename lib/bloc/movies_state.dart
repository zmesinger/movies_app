part of 'movies_bloc.dart';

@immutable
abstract class MoviesState extends Equatable {}

class MoviesInitial extends MoviesState {
  @override
  List<Object?> get props => [];
}

class StateFetchingMovies extends MoviesState {

  @override
  List<Object?> get props => [];
}

class StateMoviesFetched extends MoviesState {
  final Response data;

  StateMoviesFetched(this.data);

  @override
  List<Object?> get props => [data];
}

class StateMoviesFailed extends MoviesState {
  final String errorMessage;

  StateMoviesFailed(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];

}

class StateDetailsFetched extends MoviesState {
  final Movie movie;

  StateDetailsFetched(this.movie);

  @override
  List<Object?> get props => [movie];

}
