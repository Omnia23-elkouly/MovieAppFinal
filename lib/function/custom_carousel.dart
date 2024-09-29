import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:untitled18/Api/utils%20api.dart';
import 'package:untitled18/models/PopularMovie.dart';

import '../models/UpcomingMovie.dart';

class CustomCarousel extends StatelessWidget {
  final PopularMovie data;

  const CustomCarousel({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: 280,
      child: CarouselSlider.builder(
        itemCount: data.results?.length,
        itemBuilder: (BuildContext context, int index, int realIndex) {
          var url = data.results?[index].posterPath.toString();

          return GestureDetector(
              child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Opacity(
                opacity: 0.9,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: "$imageUrl$url",
                      height: 250,
                      width: double.maxFinite,
                      fit: BoxFit.cover,
                    ),
                    Icon(
                      Icons.play_circle_fill_outlined,
                      size: 100,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Expanded(
                            child: Row(
                              //  mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    '$imageUrl${data.results?[index].posterPath}',
                                    width: 100,
                                    height: 250,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 40),
                                  color: Colors.black,
                                  height: 50,
                                  width: 200,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${data.results?[index].title}',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        '${data.results?[index].releaseDate}',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              )
            ],
          ));
        },
        options: CarouselOptions(
            height: 280,
            aspectRatio: 16 / 9,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            initialPage: 0),
      ),
    );
  }
}
//CachedNetworkImage(imageUrl:"$imageUrl$url")
