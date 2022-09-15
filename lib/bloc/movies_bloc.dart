import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/database/watchlist_db.dart';
import 'package:movies_app/model/movie.dart';
import 'package:movies_app/model/response.dart';
import 'package:movies_app/service/movies_service.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {

  final db = WatchlistDb();
  static const _platform = MethodChannel("com.example.moviesApp/network");
  late bool _isNetworkAvailable;





  MoviesBloc() : super(MoviesInitial())  {
     _isNetworkAvailable = _initNetworkHandler();

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
      Stream<List<MovieTableData>> movies = db.watchMovies();

      if(await movies.isEmpty) {
        emit(StateMoviesFailed("No movies saved in watchlist!"));
      }else{
        emit(StateMoviesFetchedFromDb(movies));
      }
    });
    on<EventAddToWatchlist>((event, emit) {
      db.insertMovie(event.movie);
      emit(StateMovieInserted());
    });
    on<EventRemoveFromWatchlist>((event, emit) async {
      db.deleteMovie(event.id);
      emit(StateMovieRemoved());
    });
    on<EventGetNetwork>((event, emit) async {
        emit(StateNetworkAvailable(await _getNetworkStatus(), true));
    });
    on<EventCheckNetwork>((event, emit) {
      if(_isNetworkAvailable){
        emit(StateNetworkAvailable("Connected to network", _isNetworkAvailable));
      }else{
        emit(StateNetworkNotAvailable(_isNetworkAvailable));
      }
    });

  }

  Future<Response?> getData(String query) async => await MoviesService().getMovies(query);

  Future<Movie?> getMovieDetail(String imdbID) async => await MoviesService().getMovieDetails(imdbID);

  Future<String> _getNetworkStatus() async{
    String networkAvailable;
    try{
      final bool result = await _platform.invokeMethod("getNetwork");
      if(result){
        networkAvailable = "Connected to network";
      }else{
        networkAvailable = "No network connection";
      }
    }on PlatformException catch (e){
      networkAvailable = "Failed getting network info: '${e.message}'";
    }
    return networkAvailable;
  }





  bool _initNetworkHandler(){
    bool status = false;
    _platform.setMethodCallHandler((call) async {
      switch(call.method){
        case "onNetworkChanged":
          status = call.arguments["status"];
          print("status:$status");
          _isNetworkAvailable = call.arguments["status"];
          break;
        default:
          print("No such method");
      }
    });
    return status;
  }



}
