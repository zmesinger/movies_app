import 'package:drift/drift.dart';

class MovieTable extends Table{

  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get year => text()();
  TextColumn get imdbId => text()();
  TextColumn get poster => text()();

}