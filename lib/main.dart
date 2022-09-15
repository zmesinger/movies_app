import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/movies_bloc.dart';
import 'package:movies_app/database/watchlist_db.dart';
import 'package:movies_app/model/search.dart';
import 'package:movies_app/screen/details.dart';
import 'package:movies_app/screen/watchlist.dart';
import 'package:drift/drift.dart' as drift;

void main() {
  runApp(BlocProvider(
      create: (BuildContext context) => MoviesBloc()
      , child: const MyApp()
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Movies App",
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
      ),
      home: const Movies(),
    );
  }
}

class Movies extends StatefulWidget {
  const Movies({Key? key}) : super(key: key);

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  List<Search> _movies = [];
  final TextEditingController _queryController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MoviesApp"),
        actions: [
          IconButton(onPressed: _showWatchlist, icon: const Icon(Icons.list))
        ],
      ),
      body:
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _queryController,
              decoration: InputDecoration(
                suffixIcon: IconButton(onPressed: () {
                  BlocProvider.of<MoviesBloc>(context).add(
                      EventFetchMovies(_queryController.text));
                },
                  icon: const Icon(Icons.search),
                ),
                border: const OutlineInputBorder(),
                hintText: "Enter query",
              ),
            ),
          ),
          BlocConsumer<MoviesBloc, MoviesState>(
            listener: (prev, curr) {
              if(curr is StateMovieInserted){
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text("Movie added to watchlist"),
                      duration: const Duration(seconds: 1),
                      action: SnackBarAction(
                          label: "HIDE",
                          onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar),)
                );
              }
            },
            buildWhen: (prev, curr) {
              return curr is StateFetchingMovies || curr is StateMoviesFetched || curr is StateMoviesFailed;
            },
            builder: (context, state) {
              if (state is StateFetchingMovies) {
                return Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                );
              } else if (state is StateMoviesFetched) {
                _movies = state.data.search!;
                return Expanded(
                  child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_movies[index].title!),
                          subtitle: Text(_movies[index].year!),
                          leading:  _displayPoster(_movies[index].poster),
                          onTap: () => _showDetails(_movies[index].imdbId!),
                          trailing: IconButton(
                              onPressed: (){
                                BlocProvider.of<MoviesBloc>(context).add(
                                    EventAddToWatchlist(MovieTableCompanion(
                                      title: drift.Value(_movies[index].title!),
                                      year: drift.Value(_movies[index].year!),
                                      poster: drift.Value(_movies[index].poster!),
                                      imdbId: drift.Value(_movies[index].imdbId!),
                                    )
                                        ));
                                },
                              icon: const Icon(Icons.add_circle_outline_sharp)),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: _movies.length),
                );
              } else if (state is StateMoviesFailed) {
                return Center(
                  child: Row(
                    children: [
                      Center(
                          child: Text(state.errorMessage)),
                    ],
                  ),
                );
              }
              else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
   _showDetails(String imdbID){
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (context){
        return BlocProvider<MoviesBloc>.value(
          value: BlocProvider.of<MoviesBloc>(context),
          child: Details(imdbID: imdbID,),
        );
      }
      )
    );
  }



   _showWatchlist() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (context) {
        return BlocProvider<MoviesBloc>.value(
            value: BlocProvider.of<MoviesBloc>(context),
            child: const Watchlist(),);
      })
    );
  }

  Widget _displayPoster(String? posterUrl){
    if(posterUrl == null || posterUrl.isEmpty){
      return Image.network("https://cdn.pixabay.com/photo/2012/04/12/20/12/x-30465_960_720.png");
    }else{
      return Image.network(posterUrl);
    }
  }
}