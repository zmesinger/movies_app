import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:movies_app/database/movie_table.dart';
import 'package:path_provider/path_provider.dart';

part 'watchlist_db.g.dart';

LazyDatabase _openConnection(){
  return LazyDatabase(() async{
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'watchlist.sqlite'));
    
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [MovieTable])
class WatchlistDb  extends _$WatchlistDb{

  WatchlistDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Stream<List<MovieTableData>> watchMovies()  {
    return  (select(movieTable).watch());
  }

  Future<int> insertMovie(MovieTableCompanion movie ) async{
      return await into(movieTable).insert(movie);
  }

  Future<int> deleteMovie(int id) async{
    return await (delete(movieTable)..where((tbl) => tbl.id.equals(id))).go();
  }

}