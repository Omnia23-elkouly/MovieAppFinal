import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:untitled18/Api/Api.dart';
import 'package:untitled18/function/movie_card_recommendations.dart';
import 'package:untitled18/models/MovieDetailed.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Api/utils api.dart';
import '../function/movie_card.dart';

import '../function/trailer_movie.dart';
import '../models/MovieRecommendations.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;

  const MovieDetailScreen({super.key, required this.movieId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  Api api = Api();
  late Future<MovieDetailed> movieDetail;
  late Future<MovieRecommendations> movieRecommendations;

  void initState() {
    super.initState();
    fetchInitialData();
  }

  fetchInitialData() {
    movieDetail = api.getMoviesDetail(widget.movieId);
    movieRecommendations = api.getMoviesRecommendations(widget.movieId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('movie id ${widget.movieId}');

    return Scaffold(
        body: FutureBuilder(
            future: movieDetail,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final movie = snapshot.data;
                String? genereText =
                    movie!.genres?.map((genre) => genre.name).join(',');

                return SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                      Container(
                        color: Colors.white10,
                        height: 80,
                        width: 20,
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 40,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            SizedBox(
                              width: 60,
                            ),
                            Expanded(
                                child: Text(
                              '${movie!.title}',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            )),
                          ],
                        ),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        '$imageUrl${movie!.posterPath}'),
                                    fit: BoxFit.cover)),
                          ),
                          Icon(
                            Icons.play_circle_fill_outlined,
                            size: 100,
                            color: Colors.white,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${movie!.title}',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Text('${movie!.releaseDate}',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 20)),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Stack(
                                  children: [
                                    Image.network(
                                      '$imageUrl${movie!.posterPath}',
                                      width: 200,
                                      height: 250,
                                    ),
                                    Stack(
                                      children: [
                                        Icon(
                                          Icons.bookmark,
                                          size: 60,
                                          color: Colors.black54,
                                        ),
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.add,
                                              size: 40,
                                              color: Colors.white,
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        genereText!,
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 15),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        '${movie!.overview}',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 15),
                                        maxLines: 7,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star_rate_rounded,
                                            color: Colors.amber,
                                          ),
                                          Text('${movie!.voteAverage}')
                                        ],
                                      )
                                    ]),
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
                                child: MovieCardRecommendations(
                                    future: movieRecommendations,
                                    headLineText: 'More Like this')),
                          ),
                        ],
                      ),
                    ]));
              } else {
                return SizedBox();
              }
            }));
  }
}
