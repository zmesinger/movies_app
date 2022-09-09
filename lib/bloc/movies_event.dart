part of 'movies_bloc.dart';

@immutable
abstract class MoviesEvent extends Equatable{

}

class EventFetchMovies extends MoviesEvent {
  final String query;

  EventFetchMovies(this.query);

  @override
  List<Object?> get props => [query];
}

class EventReturnToInitial extends MoviesEvent {
  @override
  List<Object?> get props => [];

}

class EventShowMovieDetails extends MoviesEvent {
  final String imdbID;

  EventShowMovieDetails(this.imdbID);
  @override
  List<Object?> get props => [imdbID];

}
