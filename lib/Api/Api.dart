import 'dart:convert';
import 'dart:developer';

import 'package:untitled18/Api/utils%20api.dart';
import 'package:http/http.dart' as http;
import 'package:untitled18/models/MovieDetailed.dart';
import 'package:untitled18/models/MovieRecommendations.dart';
import 'package:untitled18/models/PopularMovie.dart';
import 'package:untitled18/models/Search.dart';

import '../models/UpcomingMovie.dart';
import '../models/movie.dart';

const baseUrl = "https://api.themoviedb.org/3/";
var key = "?api_key=$apiKey";
late String endpoint;

class Api {
  Future<UpcomingMovie> getUpcomingMovies() async {
    print("heu");
    endpoint = "movie/upcoming";
    final url = "$baseUrl$endpoint$key";
    final response = await http.get(Uri.parse(url));
    print("hey");
    if (response.statusCode == 200) {
      log('Success');
      return UpcomingMovie.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load upcoming movies");
  }

  Future<UpcomingMovie> getTopRatedMovies() async {
    print("heu");
    endpoint = "movie/top_rated";
    final url = "$baseUrl$endpoint$key";
    final response = await http.get(Uri.parse(url));
    print("hey");
    if (response.statusCode == 200) {
      log('Success');
      return UpcomingMovie.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load top_rated movies");
  }

  Future<PopularMovie> getPopularMovies() async {
    print("heu");
    endpoint = "movie/popular";
    final url = "$baseUrl$endpoint$key";
    final response = await http.get(Uri.parse(url));
    print("hey");
    if (response.statusCode == 200) {
      log('Success');
      return PopularMovie.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load popular movies");
  }

  Future<MovieDetailed> getMoviesDetail(int movieId) async {
    print("heu");
    endpoint = "movie/$movieId";
    final url = "$baseUrl$endpoint$key";
    final response = await http.get(Uri.parse(url));
    print("hey");
    if (response.statusCode == 200) {
      log('Success');
      return MovieDetailed.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load  movies details");
  }

  Future<MovieRecommendations> getMoviesRecommendations(int movieId) async {
    print("heu");
    endpoint = "movie/$movieId/recommendations";
    final url = "$baseUrl$endpoint$key";
    final response = await http.get(Uri.parse(url));
    print("hey");
    if (response.statusCode == 200) {
      log('Success');
      return MovieRecommendations.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load  movies more like this");
  }
}
