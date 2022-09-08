import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/model/response.dart';
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
      emit (StateMoviesFetched(data!));
    });
    on<EventReturnToInitial>((event, emit) {
      emit(MoviesInitial());
    });
  }
}
