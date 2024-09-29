import 'package:flutter/material.dart';
import 'package:untitled18/models/PopularMovie.dart';

import '../Api/Api.dart';
import '../function/custom_carousel.dart';
import '../function/movie_card.dart';
import '../function/movie_card_New.dart';
import '../models/UpcomingMovie.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<UpcomingMovie> upcomingFuture;
  late Future<UpcomingMovie> topRatedMovies;
  late Future<PopularMovie> popularMovies;
  Api api = Api();

  void initState() {
    super.initState();
    upcomingFuture = api.getUpcomingMovies();
    topRatedMovies = api.getTopRatedMovies();
    popularMovies = api.getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Container(
              color: Colors.black,
              child: FutureBuilder(
                  future: popularMovies,
                  builder: (context, snapshot) {
                    return CustomCarousel(data: snapshot.data!);
                  }),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Container(
                color: Colors.white10,
                child: SizedBox(
                    height: 250,
                    child: MovieCardNew(
                        future: upcomingFuture, headLineText: 'New Releases ')),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            color: Colors.white10,
            child: SizedBox(
                height: 350,
                child: MovieCard(
                    future: topRatedMovies, headLineText: 'Recomended')),
          ),
        ],
      ),
    ));
  }
}
