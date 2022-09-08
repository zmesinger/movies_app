import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/model/Response.dart';
import 'package:movies_app/service/movies_service.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {

  Future<Response?> getData() async {
    return await MoviesService().getMovies();
  }

  MoviesBloc() : super(MoviesInitial())  {
    on<EventFetchMovies>((event, emit) async {
      emit(StateFetchingMovies());
      Response? data = await getData();
      print(data);
      print(data!.search);
      emit (StateMoviesFetched(data!));
    });
  }
}
