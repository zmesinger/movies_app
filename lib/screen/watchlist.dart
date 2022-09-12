import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              listener: (prev, curr) {
                if (curr is StateMovieRemoved) {
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
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(state.movies[index].title!),
                            subtitle: Text(state.movies[index].year!),
                            leading: _displayPoster(state.movies[index].poster),
                            trailing: IconButton(icon: const Icon(
                                Icons.remove_circle_outline_sharp),
                                onPressed: () {
                                  BlocProvider.of<MoviesBloc>(context).add(
                                      EventRemoveFromWatchlist(
                                          state.movies[index]));
                                }),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: state.movies.length),
                  );
                } else {
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

}
