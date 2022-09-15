
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/movies_bloc.dart';

class Details extends StatefulWidget {

  const Details({Key? key, required this.imdbID}) : super(key: key);

  final String imdbID;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {



  @override
  void initState() {
    super.initState();
    BlocProvider.of<MoviesBloc>(context).add(EventShowDetails(widget.imdbID));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state){
          if(state is StateFetchingMovieDetails){
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }else if(state is StateDetailsFetched){
            final List<String> actors = _createActors(state.movie.actors!);
            return Scaffold(
              appBar: AppBar(
                title: Text(state.movie.title!),
              ),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Image.network(state.movie.poster!),),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildPaddedText("Genre: ${state.movie.genre}"),
                              _buildPaddedText("Year: ${state.movie.year}"),
                              _buildPaddedText("Plot: ${state.movie.plot}")
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                        ),
                        Expanded(
                          child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return ListTile(
                                  visualDensity: VisualDensity.compact,
                                  title: Text(actors[index]),
                                  leading: const Icon(Icons.circle,
                                    size: 8,),
                                );
                              },
                              separatorBuilder: (context, index){
                                return const Divider();
                          },
                              itemCount: actors.length),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }else if(state is StateMoviesFailed){
            return Center(child: Text(state.errorMessage),);
          }else{
            return Container();
          }
        }
    );
  }

  List<String> _createActors(String actors)=> actors.split(", ");
  
  Widget _buildPaddedText(String content) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(content),
    );
}
