
import 'package:floor/floor.dart';
import 'package:movies_app/model/movie.dart';

@dao
abstract class MovieDao {
  @Query("SELECT * FROM Movie")
  Future<List<Movie>> getMovies();
  
  @Query("SELECT * FROM Movie WHERE imdbId = :imdbId")
  Stream<Movie?> getMovieById(String imdbId);

  @Query("SELECT * FROM Movie")
  Stream<List<Movie>> watchMovies();

  @insert
  Future<void> insertMovie(Movie movie);

  @delete
  Future<void> deleteMovie(Movie movie);

}