import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/main.dart';
import 'package:movies_app/main.dart';

import '../bloc/movies_bloc.dart';
import '../database/watchlist_db.dart';

class WatchlistDetail extends StatefulWidget {
  const WatchlistDetail({Key? key, required this.movies, required this.index}) : super(key: key);

  final List<MovieTableData> movies;
  final int index;

  @override
  State<WatchlistDetail> createState() => _WatchlistDetailState();

}


class _WatchlistDetailState extends State<WatchlistDetail> {

  late PageController controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: widget.index);
    BlocProvider.of<MoviesBloc>(context).add(
        EventShowWatchlistDetail(widget.movies, widget.index));

  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        if(state is StateMovieListFetched){

          return PageView.builder(
            itemCount: state.movies.length,
            controller: controller,
            itemBuilder: (context, index){
              return Scaffold(
                appBar: AppBar(
                  title: Text(state.movies[index].title),
                ),
                body: Column(
                  children: [
                    Padding(padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Image.network(state.movies[index].poster),),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildPaddedText("Title: ${state.movies[index].title}"),
                              _buildPaddedText("Year: ${state.movies[index].year}"),
                              _buildPaddedText("ImdbID: ${state.movies[index].imdbId}")
                            ],
                          ),
                        ),
                      ],
                    ),
                    ),

                  ],
                ),
              );
            },
          );
        }else{
          return Container();
        }
      },
    );
  }



  Widget _buildPaddedText(String content) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(content),
  );

}
