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

class EventShowDetails extends MoviesEvent {
  final String imdbID;

  EventShowDetails(this.imdbID);
  @override
  List<Object?> get props => [imdbID];

}

class EventShowWatchlist extends MoviesEvent{

  @override
  List<Object?> get props => [];

}

class EventAddToWatchlist extends MoviesEvent {
  final String imdbId;

  EventAddToWatchlist(this.imdbId);

  @override
  List<Object?> get props => [imdbId];


}
