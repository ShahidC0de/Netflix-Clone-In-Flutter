import 'dart:convert';
import 'dart:developer';

import 'package:netflix_clone/commons/util.dart';
import 'package:netflix_clone/models/upcoming_movie_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = "https://api.themoviedb.org/3/";
var key = "?api_key=$apiKey";
late String endPoint;

class ApiServices {
  Future<UpcomingMovieModel> getUpcomingMovies() async {
    String endPointUrl = "movie/upcoming";
    String url = "$baseUrl$endPointUrl$key";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        log("success");
        return UpcomingMovieModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      log(e.toString());
    }
    throw Exception('error fetching the data');
  }

  Future<UpcomingMovieModel> getNowPlayingMovies() async {
    String endPointUrl = "movie/now_playing";
    String url = "$baseUrl$endPointUrl$key";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        log("success");
        return UpcomingMovieModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      log(e.toString());
    }
    throw Exception('error fetching the noe_playing movies');
  }
}
