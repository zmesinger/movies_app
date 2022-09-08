import '../model/Response.dart';
import 'package:http/http.dart' as http;

class MoviesService {

  Future<Response?> getMovies() async {
    var client = http.Client();
    var uri = Uri.parse("http://omdbapi.com/?s=lord&apikey=47b04f74");
    var response = await client.get(uri);

    if(response.statusCode == 200){
      var json = response.body;
      return responseFromJson(json);
    }
  }

}