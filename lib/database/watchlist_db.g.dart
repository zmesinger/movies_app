// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watchlist_db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorWatchlistDb {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$WatchlistDbBuilder databaseBuilder(String name) =>
      _$WatchlistDbBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$WatchlistDbBuilder inMemoryDatabaseBuilder() =>
      _$WatchlistDbBuilder(null);
}

class _$WatchlistDbBuilder {
  _$WatchlistDbBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$WatchlistDbBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$WatchlistDbBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<WatchlistDb> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$WatchlistDb();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$WatchlistDb extends WatchlistDb {
  _$WatchlistDb([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MovieDao? _movieDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Movie` (`title` TEXT, `year` TEXT, `rated` TEXT, `released` TEXT, `runtime` TEXT, `genre` TEXT, `director` TEXT, `writer` TEXT, `actors` TEXT, `plot` TEXT, `language` TEXT, `country` TEXT, `awards` TEXT, `poster` TEXT, `metascore` TEXT, `imdbRating` TEXT, `imdbVotes` TEXT, `imdbId` TEXT, `type` TEXT, `dvd` TEXT, `boxOffice` TEXT, `production` TEXT, `website` TEXT, `response` TEXT, PRIMARY KEY (`imdbId`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MovieDao get movieDao {
    return _movieDaoInstance ??= _$MovieDao(database, changeListener);
  }
}

class _$MovieDao extends MovieDao {
  _$MovieDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _movieInsertionAdapter = InsertionAdapter(
            database,
            'Movie',
            (Movie item) => <String, Object?>{
                  'title': item.title,
                  'year': item.year,
                  'rated': item.rated,
                  'released': item.released,
                  'runtime': item.runtime,
                  'genre': item.genre,
                  'director': item.director,
                  'writer': item.writer,
                  'actors': item.actors,
                  'plot': item.plot,
                  'language': item.language,
                  'country': item.country,
                  'awards': item.awards,
                  'poster': item.poster,
                  'metascore': item.metascore,
                  'imdbRating': item.imdbRating,
                  'imdbVotes': item.imdbVotes,
                  'imdbId': item.imdbId,
                  'type': item.type,
                  'dvd': item.dvd,
                  'boxOffice': item.boxOffice,
                  'production': item.production,
                  'website': item.website,
                  'response': item.response
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Movie> _movieInsertionAdapter;

  @override
  Future<List<Movie>> getMovies() async {
    return _queryAdapter.queryList('SELECT * FROM Movie',
        mapper: (Map<String, Object?> row) => Movie(
            title: row['title'] as String?,
            year: row['year'] as String?,
            rated: row['rated'] as String?,
            released: row['released'] as String?,
            runtime: row['runtime'] as String?,
            genre: row['genre'] as String?,
            director: row['director'] as String?,
            writer: row['writer'] as String?,
            actors: row['actors'] as String?,
            plot: row['plot'] as String?,
            language: row['language'] as String?,
            country: row['country'] as String?,
            awards: row['awards'] as String?,
            poster: row['poster'] as String?,
            metascore: row['metascore'] as String?,
            imdbRating: row['imdbRating'] as String?,
            imdbVotes: row['imdbVotes'] as String?,
            imdbId: row['imdbId'] as String?,
            type: row['type'] as String?,
            dvd: row['dvd'] as String?,
            boxOffice: row['boxOffice'] as String?,
            production: row['production'] as String?,
            website: row['website'] as String?,
            response: row['response'] as String?));
  }

  @override
  Future<Movie?> getMovieById(String imdbId) async {
    return _queryAdapter.query('SELECT * FROM Movie WHERE imdbId = ?1',
        mapper: (Map<String, Object?> row) => Movie(
            title: row['title'] as String?,
            year: row['year'] as String?,
            rated: row['rated'] as String?,
            released: row['released'] as String?,
            runtime: row['runtime'] as String?,
            genre: row['genre'] as String?,
            director: row['director'] as String?,
            writer: row['writer'] as String?,
            actors: row['actors'] as String?,
            plot: row['plot'] as String?,
            language: row['language'] as String?,
            country: row['country'] as String?,
            awards: row['awards'] as String?,
            poster: row['poster'] as String?,
            metascore: row['metascore'] as String?,
            imdbRating: row['imdbRating'] as String?,
            imdbVotes: row['imdbVotes'] as String?,
            imdbId: row['imdbId'] as String?,
            type: row['type'] as String?,
            dvd: row['dvd'] as String?,
            boxOffice: row['boxOffice'] as String?,
            production: row['production'] as String?,
            website: row['website'] as String?,
            response: row['response'] as String?),
        arguments: [imdbId]);
  }

  @override
  Future<void> insertMovie(Movie movie) async {
    await _movieInsertionAdapter.insert(movie, OnConflictStrategy.abort);
  }
}
