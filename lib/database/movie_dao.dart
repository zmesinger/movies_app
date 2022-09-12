
import 'package:floor/floor.dart';
import 'package:movies_app/model/movie.dart';

@dao
abstract class MovieDao {
  @Query("SELECT * FROM Movie")
  Future<List<Movie>> getMovies();
  
  @Query("SELECT * FROM Movie WHERE imdbId = :imdbId")
  Future<Movie?> getMovieById(String imdbId);

  @insert
  Future<void> insertMovie(Movie movie);

}