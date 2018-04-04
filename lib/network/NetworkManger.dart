import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movietime_app/network/Configs.dart';

class NetworkManager {

  Future<List<Movie>> getMovieData(int page) async {
    var response = await http.get(
      Uri.encodeFull(getUrl(page)),
      headers: {
        "Accept" : "application/json"
      }
    );

    Map data = json.decode(response.body);
    return convertMapToModel(data["results"]);
  }

  String getUrl(int page) {
    print(Configs.BASE_URL + Configs.DISCOVER_PATH + Configs.API_KEY + "&page="+page.toString());
    return Configs.BASE_URL + Configs.DISCOVER_PATH + Configs.API_KEY + "&page="+page.toString();
  }

  List<Movie> convertMapToModel(data) {
    List<Movie> movieData = new List<Movie>();
    for(data in data) {
      movieData.add(new Movie(data["original_title"],
          data["poster_path"],data["backdrop_path"],data["overview"]));
    }

    return movieData;
  }

}

class Movie {
  String mTitle;
  String mPosterUrl;
  String mBackdropUrl;
  String mDescription;

  Movie(this.mTitle, this.mPosterUrl, this.mBackdropUrl, this.mDescription);
}