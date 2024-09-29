import 'package:flutter/material.dart';
import 'package:untitled18/Api/utils%20api.dart';
import 'package:untitled18/models/MovieDetailed.dart';
import 'package:untitled18/models/MovieRecommendations.dart';
import 'package:untitled18/screen/movie_detail_screen.dart';

import '../models/UpcomingMovie.dart';

class MovieCardRecommendations extends StatelessWidget {
  final Future<MovieRecommendations> future;
  final String headLineText;

  const MovieCardRecommendations(
      {required this.future, required this.headLineText});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data?.results;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  headLineText,
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: data!.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MovieDetailScreen(
                                          movieId: data[index].id!)));
                            },
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    width: 150,
                                    height: 300,
                                    margin: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white10,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black87
                                                  .withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 6)
                                        ]),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              topRight: Radius.circular(10),
                                            ),
                                            child: Stack(
                                              alignment: Alignment.topLeft,
                                              children: [
                                                Image.network(
                                                  "$imageUrl${data[index].posterPath}",
                                                  height: 200,
                                                  width: 150,
                                                  fit: BoxFit.cover,
                                                ),
                                                Stack(
                                                  children: [
                                                    Icon(Icons.bookmark,
                                                        size: 60,
                                                        color: Colors.black54),
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
                                            )),
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 5)),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${data?[index].title}',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                              maxLines: 7,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 3),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star_rate_rounded,
                                                  color: Colors.amber,
                                                  size: 25,
                                                ),
                                                Text(
                                                    '${data?[index].voteAverage}',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 15))
                                              ],
                                            ),
                                          ],
                                        ),

                                        // Icon(Icons.add_box_rounded,color: Colors.amber,),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return SizedBox.shrink();
          }
        });
  }
}
