import 'dart:convert';
import 'dart:developer';

import 'package:netflix_clone/commons/util.dart';
import 'package:netflix_clone/models/movie_detail_model.dart';
import 'package:netflix_clone/models/popular_movies_model.dart';
import 'package:netflix_clone/models/recommend_movie_model.dart';
import 'package:netflix_clone/models/search_movie_model.dart';
import 'package:netflix_clone/models/top_rated_movie_model.dart';
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

  Future<TopRatedMovieModel> getTopRatedMovies() async {
    String endPointUrl = "movie/top_rated";
    String url = "$baseUrl$endPointUrl$key";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        log("top rated successed");
        return TopRatedMovieModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      log(e.toString());
    }
    throw Exception('error fetching the top_rated movies');
  }

  Future<SearchMovieModel> getSearchedMovies(String searchText) async {
    String endPointUrl =
        "search/movie?query=$searchText"; // corrected parameter name
    String url = "$baseUrl$endPointUrl";

    final response = await http.get(Uri.parse(url), headers: {
      'Authorization':
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxMzExNjljZDY3OTc5MGE2OTE0MjU2YzlhMTMyMjY5MiIsInN1YiI6IjY2MDA3MTk5MDQ3MzNmMDE3ZGVkZWJkZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.gPeYAFTteJTCONjzp09yY0WE351VTiCjbO3ng60o-8c"
    });

    if (response.statusCode == 200) {
      log('Success! Response Body: ${response.body}');
      return SearchMovieModel.fromJson(jsonDecode(response.body));
    } else {
      log('Error! Status Code: ${response.statusCode}, Response Body: ${response.body}');
      throw Exception(
          "Unable to get searched Movies. Status Code: ${response.statusCode}");
    }
  }

  Future<PopularMoviesModel> getPopularMovies() async {
    String endPointUrl = "movie/popular";
    String url = "$baseUrl$endPointUrl$key";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        log("popular movies recieved");
        return PopularMoviesModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      log(e.toString());
    }
    throw Exception('not recieved');
  }

  Future<MovieDetailModel> getMovieDetails(int movieId) async {
    String endPointUrl = "movie/$movieId";
    String url = "$baseUrl$endPointUrl$key";
    log(url);
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        log('details recieved');
        return MovieDetailModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      log(e.toString());
    }
    throw Exception();
  }

  Future<RecommendMovieModel> getrecommendedMovies(int movieId) async {
    String endPointUrl = "movie/$movieId/recommendations";
    String url = "$baseUrl$endPointUrl$key";
    log("url is $url");
    log(url);
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        log('recommended movies recieved');
        return RecommendMovieModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      log(e.toString());
    }
    throw Exception();
  }

  // Future<PopularMoviesModel> getPopularMovies() async {
  //   String endPointUrl = "movie/popular";
  //   String url = "$baseUrl$endPointUrl$key";
  //   try {
  //     final response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       log("popular movies received");
  //       // Check if response body is not null
  //       if (response.body != null) {
  //         // Decode JSON only if response body is not null
  //         final decodedBody = jsonDecode(response.body);
  //         // Check if decoded JSON is in the expected format (Map<String, dynamic>)
  //         if (decodedBody is Map<String, dynamic>) {
  //           return PopularMoviesModel.fromJson(decodedBody);
  //         } else {
  //           throw Exception('Invalid response format');
  //         }
  //       } else {
  //         throw Exception('Response body is null');
  //       }
  //     } else {
  //       throw Exception(
  //           'Failed to fetch popular movies: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //     throw Exception('Failed to fetch popular movies: $e');
  //   }
  // }
}
