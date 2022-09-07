part of 'movies_bloc.dart';

@immutable
abstract class MoviesEvent extends Equatable{

}

class EventFetchMovies extends MoviesEvent {
  @override
  List<Object?> get props => [];

}
