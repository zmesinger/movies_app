import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/database/watchlist_db.dart';
import 'package:movies_app/screen/watchlist_detail.dart';
import '../bloc/movies_bloc.dart';
import 'details.dart';

class Watchlist extends StatefulWidget {
  const Watchlist({Key? key}) : super(key: key);

  @override
  State<Watchlist> createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MoviesBloc>(context).add(EventShowWatchlist());
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Watchlist"),
        ),
        body: Column(
          children: [
            BlocConsumer<MoviesBloc, MoviesState>(
              listener: (context, state) {
                if (state is StateMovieRemoved) {
                  setState(() {

                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: const Text("Movie removed from watchlist"),
                          duration: const Duration(seconds: 1),
                          action: SnackBarAction(
                            label: "HIDE",
                            onPressed: ScaffoldMessenger
                                .of(context)
                                .hideCurrentSnackBar,)
                      )
                  );
                }
              },
              buildWhen: (prev, curr){
                return curr is StateFetchingMoviesFromDb || curr is StateMoviesFetchedFromDb;
              },
              builder: (context, state) {

                if (state is StateFetchingMoviesFromDb) {
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
                } else if (state is StateMoviesFetchedFromDb) {

                  return Expanded(
                    child: StreamBuilder(
                      stream: state.movies,
                        builder: (context, snapshot){
                          if(!snapshot.hasData){
                            return const Center(
                              child: CircularProgressIndicator(),);
                          }else{
                            List<MovieTableData> movies = snapshot.requireData;
                          return ListView.separated(
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(movies[index].title),
                                  subtitle: Text(movies[index].year),
                                  leading: _displayPoster(movies[index].poster),
                                  onTap:() {
                                    _showDetails(movies, index);
                                  },
                                  trailing: InkWell(
                                    onTap: (){
                                      BlocProvider.of<MoviesBloc>(context).add(
                                          EventRemoveFromWatchlist(
                                              movies[index].id));
                                    },
                                    child: const Icon(Icons.remove_circle_outline_sharp),
                                  )
                                );
                              },
                              separatorBuilder: (context, index){
                                return const Divider();
                              },
                              itemCount: movies!.length);
                        }}),
                  );
                } else if(state is StateMoviesFailed){
                      return Column(
                        children: [
                          Center(
                            child: Text(state.errorMessage),
                          )
                        ],
                      );
                }else{
                  return Container();
                }
              },
            ),
          ],
        )
    );
  }

  Widget _displayPoster(String? posterUrl) {
    if (posterUrl == null || posterUrl.isEmpty) {
      return Image.network(
          "https://cdn.pixabay.com/photo/2012/04/12/20/12/x-30465_960_720.png");
    } else {
      return Image.network(posterUrl);
    }
  }
  _showDetails(List<MovieTableData> movies, int index){
    Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (context){
          return BlocProvider<MoviesBloc>.value(
            value: BlocProvider.of<MoviesBloc>(context),
            child: WatchlistDetail(movies: movies, index: index,)
          );
        }
        )
    );
  }



}
