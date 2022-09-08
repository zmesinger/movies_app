import '../model/response.dart';
import 'package:http/http.dart' as http;

class MoviesService {

  Future<Response?> getMovies(String query) async {
    var client = http.Client();
    var uri = Uri.parse("http://omdbapi.com/?s=$query&apikey=47b04f74");
    var response = await client.get(uri);
    print(response.body.toString());
    if(response.statusCode == 200){
      var json = response.body;
      return responseFromJson(json);
    }
    return null;
  }

}