import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/movies_bloc.dart';
import 'package:movies_app/model/search.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MoviesApp"),
        actions: [
          IconButton(
              onPressed: (){
                BlocProvider.of<MoviesBloc>(context).add(EventReturnToInitial());
              },
              icon: Icon(Icons.arrow_back))
        ],
      ),
      body: BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
          if(state is MoviesInitial){
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.get_app),
                    onPressed: () {
                      BlocProvider.of<MoviesBloc>(context).add(
                          EventFetchMovies());
                    },
                  ),
                  const Text("Get movies"),
                ],
              ),
            );
          }else if(state is StateFetchingMovies){
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CircularProgressIndicator()
                ],
              ),
            );
          }else if(state is StateMoviesFetched){
            _movies = state.data.search;
            return ListView.separated(
                itemBuilder: (context, index){
                  return ListTile(
                    title: Text(_movies[index].title!),
                    subtitle: Text(_movies[index].year!),
                  );
                },
                separatorBuilder: (context, index){
                  return const Divider();
                },
                itemCount: _movies.length);
          }else{
            return Container();
          }
        },
      ),
    );
  }
}

