import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:untitled18/screen/splash_screen.dart';
import 'package:untitled18/screen/test.dart';

import 'package:untitled18/watchlist/movielist.dart';

import 'function/bottom_nav_bar.dart';
import 'screen/home_screen.dart';
import 'theme_data.dart';
import 'package:untitled18/screen/movie_detail_screen.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_screenutil/flutter_screenutil.dart';

const String apiKey = '16eb50c303726f7de65627e41b1160f4';
const String baseUrl = 'https://api.themoviedb.org/3';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(412, 892),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: MyThemeData.darkTheme,
          initialRoute: SplashScreen.routeName,
          routes: {
            MovieSearchScreen.RouteName: (context) => MovieSearchScreen(),
            HomeScreen.routeName: (context) => HomeScreen(),
            BottomNavBar.routeName: (context) => BottomNavBar(),
            SplashScreen.routeName: (context) => SplashScreen(),
            Test.routeName: (context) => Test(),
            Watchlist.routeName: (context) => Watchlist(),
          },
        );
      },
    );
  }
}

class MovieSearchScreen extends StatefulWidget {
  static const RouteName = "Search";

  @override
  MovieSearchScreenState createState() => MovieSearchScreenState();
}

class MovieSearchScreenState extends State<MovieSearchScreen> {
  final String apiKey = '16eb50c303726f7de65627e41b1160f4';
  List movies = [];
  bool isLoading = false;

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) return;

    setState(() {
      isLoading = true;
    });

    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query'),
    );

    if (response.statusCode == 200) {
      setState(() {
        movies = json.decode(response.body)['results'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.grey, fontSize: 20),
              onSubmitted: (query) {
                searchMovies(query);
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white10,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
              ),
            ),
            SizedBox(height: 10),
            isLoading
                ? CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        final posterPath = movie['poster_path'];
                        return ListTile(
                          leading: posterPath != null
                              ? Image.network(
                                  'https://image.tmdb.org/t/p/w92$posterPath',
                                  width: 50,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  width: 50, height: 100, color: Colors.grey),
                          title: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MovieDetailScreen(
                                            movieId: movie['id'])));
                              },
                              child: Text(movie['title'],
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15))),
                          subtitle: Text(
                              'Release Date: ${movie['release_date'] ?? 'N/A'}',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15)),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

// Cubit for Genres
class GenreCubit extends Cubit<GenreState> {
  GenreCubit() : super(GenreLoadingState());

  Future<void> fetchGenres() async {
    emit(GenreLoadingState());
    try {
      final url = '$baseUrl/genre/movie/list?api_key=$apiKey&language=en-US';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final genres = json.decode(response.body)['genres'];
        emit(GenreLoadedState(genres));
      } else {
        emit(GenreErrorState());
      }
    } catch (_) {
      emit(GenreErrorState());
    }
  }
}

// States for GenreCubit
abstract class GenreState {}

class GenreLoadingState extends GenreState {}

class GenreLoadedState extends GenreState {
  final List<dynamic> genres;

  GenreLoadedState(this.genres);
}

class GenreErrorState extends GenreState {}

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121312),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50.h),
          Padding(
            padding: EdgeInsets.only(left: 20.w, bottom: 10.w),
            child: Text(
              'Browse Category',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
          Expanded(
            child: BlocBuilder<GenreCubit, GenreState>(
              builder: (context, state) {
                if (state is GenreLoadingState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is GenreLoadedState) {
                  return Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 16 / 9,
                        crossAxisSpacing: 50.w,
                        mainAxisSpacing: 50.h,
                      ),
                      itemCount: state.genres.length,
                      itemBuilder: (context, index) {
                        final genre = state.genres[index];
                        //hZVIwxi6kK4KnpVPEWwdhG0cMM5.jpg

                        String imageUrl;
                        if (genre['name'] == 'Action') {
                          imageUrl =
                              'https://image.tmdb.org/t/p/w500/58QT4cPJ2u2TqWZkterDq9q4yxQ.jpg';
                        } else if (genre['name'] == 'Comedy') {
                          imageUrl =
                              'https://image.tmdb.org/t/p/w500/A1dZ6faTjg0e6HYftBmEKujuXGQ.jpg';
                        } else if (genre['name'] == 'Music') {
                          imageUrl =
                              'https://image.tmdb.org/t/p/w500/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg'; // صورة افتراضية من الإنترنت
                        } else if (genre['name'] == 'Horror') {
                          imageUrl =
                              'https://image.tmdb.org/t/p/w500/9SSEUrSqhljBMzRe4aBTh17rUaC.jpg';
                        } else if (genre['name'] == 'Crime') {
                          imageUrl =
                              'https://image.tmdb.org/t/p/w500/wSZbtiFIK1fkKZdSRtn2kz2Ttfd.jpg';
                        } else if (genre['name'] == 'Adventure') {
                          imageUrl =
                              'https://image.tmdb.org/t/p/w500/xeEw3eLeSFmJgXZzmF2Efww0q3s.jpg';
                        } else if (genre['name'] == 'Animation') {
                          imageUrl =
                              'https://image.tmdb.org/t/p/w500/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg';
                        } else {
                          imageUrl =
                              'https://image.tmdb.org/t/p/w500/Asg2UUwipAdE87MxtJy7SQo08XI.jpg';
                        }

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) =>
                                      MovieCubit()..fetchMovies(genre['id']),
                                  child: MoviesScreen(
                                    genreId: genre['id'],
                                    genreName: genre['name'],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(
                                      child: Icon(Icons.error),
                                    );
                                  },
                                ),
                              ),
                              Center(
                                child: Text(
                                  genre['name'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          )
        ],
      ),
    );
  }
}

// Cubit for Movies
class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(MovieLoadingState());

  Future<void> fetchMovies(int genreId) async {
    emit(MovieLoadingState());
    try {
      final url =
          '$baseUrl/discover/movie?api_key=$apiKey&with_genres=$genreId&language=en-US';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final movies = json.decode(response.body)['results'];
        emit(MovieLoadedState(movies));
      } else {
        emit(MovieErrorState());
      }
    } catch (_) {
      emit(MovieErrorState());
    }
  }
}

// States for MovieCubit
abstract class MovieState {}

class MovieLoadingState extends MovieState {}

class MovieLoadedState extends MovieState {
  final List<dynamic> movies;

  MovieLoadedState(this.movies);
}

class MovieErrorState extends MovieState {}

class MoviesScreen extends StatelessWidget {
  final int genreId;
  final String genreName;

  MoviesScreen({required this.genreId, required this.genreName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121312),
      appBar: AppBar(
        backgroundColor: Color(0xff121312),
        title: Text(
          '$genreName Movies  ',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocBuilder<MovieCubit, MovieState>(
        builder: (context, state) {
          if (state is MovieLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MovieLoadedState) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
              ),
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                movie['id'] != null;
                return GestureDetector(
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MovieDetailScreen(movieId: movie['id'])));
                  },
                  child: Card(
                    color: Colors.white10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        movie['poster_path'] != null
                            ? Expanded(
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                                  fit: BoxFit.cover,
                                  height: 200.h,
                                ),
                              )
                            : Container(
                                height: 200.h,
                                color: Colors.grey,
                                child: Center(child: Text('No Image')),
                              ),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            movie['title'] ?? 'No Title',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                                fontFamily: 'inter'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is MovieErrorState) {
            return Center(child: Text('Failed to load movies'));
          }
          return Container();
        },
      ),
    );
  }
}
