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
class StateFetchingMovieDetails extends MoviesState {

  @override
  List<Object?> get props => [];
}

class StateFetchingMoviesFromDb extends MoviesState{
  @override
  List<Object?> get props => [];

}

class StateMoviesFetchedFromDb extends MoviesState{
  final Stream<List<MovieTableData>> movies;

  StateMoviesFetchedFromDb(this.movies);

  @override
  List<Object?> get props => [movies];

}

class StateMovieInserted extends MoviesState{
  @override
  List<Object?> get props => [];
}

class StateMovieRemoved extends MoviesState{
  @override
  List<Object?> get props => [];

}

class StateNetworkAvailable extends MoviesState{


  @override
  List<Object?> get props => [];
}

class StateNetworkNotAvailable extends MoviesState{


  @override
  List<Object?> get props => [];

}

class StateMovieListFetched extends MoviesState{
  final List<MovieTableData> movies;
  final int index;

  StateMovieListFetched(this.movies, this.index);

  @override
  List<Object?> get props => [movies, index];

}


