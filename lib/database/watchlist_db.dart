

import 'dart:async';
import 'package:floor/floor.dart';
import 'package:movies_app/database/movie_dao.dart';
import 'package:movies_app/model/movie.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'watchlist_db.g.dart';

@Database(version: 1, entities: [Movie])
abstract class WatchlistDb extends FloorDatabase{
  MovieDao get movieDao;
}