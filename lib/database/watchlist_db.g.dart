// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watchlist_db.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class MovieTableData extends DataClass implements Insertable<MovieTableData> {
  final int id;
  final String title;
  final String year;
  final String imdbId;
  final String poster;
  const MovieTableData(
      {required this.id,
      required this.title,
      required this.year,
      required this.imdbId,
      required this.poster});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['year'] = Variable<String>(year);
    map['imdb_id'] = Variable<String>(imdbId);
    map['poster'] = Variable<String>(poster);
    return map;
  }

  MovieTableCompanion toCompanion(bool nullToAbsent) {
    return MovieTableCompanion(
      id: Value(id),
      title: Value(title),
      year: Value(year),
      imdbId: Value(imdbId),
      poster: Value(poster),
    );
  }

  factory MovieTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MovieTableData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      year: serializer.fromJson<String>(json['year']),
      imdbId: serializer.fromJson<String>(json['imdbId']),
      poster: serializer.fromJson<String>(json['poster']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'year': serializer.toJson<String>(year),
      'imdbId': serializer.toJson<String>(imdbId),
      'poster': serializer.toJson<String>(poster),
    };
  }

  MovieTableData copyWith(
          {int? id,
          String? title,
          String? year,
          String? imdbId,
          String? poster}) =>
      MovieTableData(
        id: id ?? this.id,
        title: title ?? this.title,
        year: year ?? this.year,
        imdbId: imdbId ?? this.imdbId,
        poster: poster ?? this.poster,
      );
  @override
  String toString() {
    return (StringBuffer('MovieTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('year: $year, ')
          ..write('imdbId: $imdbId, ')
          ..write('poster: $poster')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, year, imdbId, poster);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MovieTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.year == this.year &&
          other.imdbId == this.imdbId &&
          other.poster == this.poster);
}

class MovieTableCompanion extends UpdateCompanion<MovieTableData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> year;
  final Value<String> imdbId;
  final Value<String> poster;
  const MovieTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.year = const Value.absent(),
    this.imdbId = const Value.absent(),
    this.poster = const Value.absent(),
  });
  MovieTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String year,
    required String imdbId,
    required String poster,
  })  : title = Value(title),
        year = Value(year),
        imdbId = Value(imdbId),
        poster = Value(poster);
  static Insertable<MovieTableData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? year,
    Expression<String>? imdbId,
    Expression<String>? poster,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (year != null) 'year': year,
      if (imdbId != null) 'imdb_id': imdbId,
      if (poster != null) 'poster': poster,
    });
  }

  MovieTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? year,
      Value<String>? imdbId,
      Value<String>? poster}) {
    return MovieTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      year: year ?? this.year,
      imdbId: imdbId ?? this.imdbId,
      poster: poster ?? this.poster,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (year.present) {
      map['year'] = Variable<String>(year.value);
    }
    if (imdbId.present) {
      map['imdb_id'] = Variable<String>(imdbId.value);
    }
    if (poster.present) {
      map['poster'] = Variable<String>(poster.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MovieTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('year: $year, ')
          ..write('imdbId: $imdbId, ')
          ..write('poster: $poster')
          ..write(')'))
        .toString();
  }
}

class $MovieTableTable extends MovieTable
    with TableInfo<$MovieTableTable, MovieTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MovieTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<String> year = GeneratedColumn<String>(
      'year', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _imdbIdMeta = const VerificationMeta('imdbId');
  @override
  late final GeneratedColumn<String> imdbId = GeneratedColumn<String>(
      'imdb_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _posterMeta = const VerificationMeta('poster');
  @override
  late final GeneratedColumn<String> poster = GeneratedColumn<String>(
      'poster', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title, year, imdbId, poster];
  @override
  String get aliasedName => _alias ?? 'movie_table';
  @override
  String get actualTableName => 'movie_table';
  @override
  VerificationContext validateIntegrity(Insertable<MovieTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('year')) {
      context.handle(
          _yearMeta, year.isAcceptableOrUnknown(data['year']!, _yearMeta));
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('imdb_id')) {
      context.handle(_imdbIdMeta,
          imdbId.isAcceptableOrUnknown(data['imdb_id']!, _imdbIdMeta));
    } else if (isInserting) {
      context.missing(_imdbIdMeta);
    }
    if (data.containsKey('poster')) {
      context.handle(_posterMeta,
          poster.isAcceptableOrUnknown(data['poster']!, _posterMeta));
    } else if (isInserting) {
      context.missing(_posterMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MovieTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MovieTableData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      year: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}year'])!,
      imdbId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}imdb_id'])!,
      poster: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}poster'])!,
    );
  }

  @override
  $MovieTableTable createAlias(String alias) {
    return $MovieTableTable(attachedDatabase, alias);
  }
}

abstract class _$WatchlistDb extends GeneratedDatabase {
  _$WatchlistDb(QueryExecutor e) : super(e);
  late final $MovieTableTable movieTable = $MovieTableTable(this);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [movieTable];
}
