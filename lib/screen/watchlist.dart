import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/movies_bloc.dart';

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
    return Scaffold();
  }
}
