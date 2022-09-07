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
  @override
  List<Object?> get props => [];
}
