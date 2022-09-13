import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/database/watchlist_db.dart';
import 'package:movies_app/model/movie.dart';
import 'package:movies_app/model/response.dart';
import 'package:movies_app/service/movies_service.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {


  Future<WatchlistDb> getInstance() async => await $FloorWatchlistDb.databaseBuilder("watchlist_db").build();

  Future<Response?> getData(String query) async => await MoviesService().getMovies(query);

  Future<Movie?> getMovieDetail(String imdbID) async => await MoviesService().getMovieDetails(imdbID);


  MoviesBloc() : super(MoviesInitial())  {
    on<EventFetchMovies>((event, emit) async {
      emit(StateFetchingMovies());
      Response? data = await getData(event.query);
      if(data != null){
        print(data.toString());
        if(data.search != null && data.search!.isNotEmpty){
          emit(StateMoviesFetched(data));
        }else if(data.search != null && data.search!.isEmpty){
          emit (StateMoviesFailed("No movie data"));
        }else{
          emit (StateMoviesFailed("Fetching data failed"));
        }
      } else{
        emit (StateMoviesFailed("Fetching data failed"));
      }

    });
    on<EventShowDetails>((event, emit) async {
      emit(StateFetchingMovieDetails());
      Movie? movie = await getMovieDetail(event.imdbID);
      if(movie != null){
        print(movie.toString());
        if(movie.title != null && movie.title!.isNotEmpty ){
          emit(StateDetailsFetched(movie));
        }else if(movie.response != null && movie.response == "False"){
          emit(StateMoviesFailed("No movie data"));
        }else{
          emit (StateMoviesFailed("Fetching details failed"));
        }
      }else{
        emit(StateMoviesFailed("Fetching details failed"));
      }
    });
    on<EventShowWatchlist>((event, emit) async {
      emit(StateFetchingMoviesFromDb());
      final db = await getInstance();
      Stream<List<Movie>> movies = db.movieDao.watchMovies();
      if(await movies.isEmpty) {
        emit(StateMoviesFailed("No movies saved in watchlist!"));
      }else{
        emit(StateMoviesFetchedFromDb(movies));
      }
    });
    on<EventAddToWatchlist>((event, emit) async {
      final db = await getInstance();
      Movie? movie = await getMovieDetail(event.imdbId);
      if(movie != null) {
        db.movieDao.insertMovie(movie);
      }
      emit(StateMovieInserted());
    });
    on<EventRemoveFromWatchlist>((event, emit) async {
      final db = await getInstance();
      db.movieDao.deleteMovie(event.movie);
      emit(StateMovieRemoved());
    });

  }
}
