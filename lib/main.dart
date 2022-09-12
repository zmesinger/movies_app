import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/movies_bloc.dart';
import 'package:movies_app/model/search.dart';
import 'package:movies_app/screen/details.dart';
import 'package:movies_app/screen/watchlist.dart';

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
  TextEditingController _queryController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MoviesApp"),
        actions: [
          IconButton(onPressed: _showWatchlist, icon: Icon(Icons.list))
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
          BlocBuilder<MoviesBloc, MoviesState>(
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
                          trailing: Image.network(_movies[index].poster!),
                          onTap: () => _showDetails(_movies[index].imdbId!),
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
            child: Watchlist(),);
      })
    );
  }
}