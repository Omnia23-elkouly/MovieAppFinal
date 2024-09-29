import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Watchlist extends StatefulWidget {
  static const String routeName = 'watchlist';

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<Watchlist> {
  int _selectedIndex = 3; // Default selected tab is Watchlist

  // This method will be called when the user taps on the bottom navigation items
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            MovieCard(
              title: 'The Shawshank Redemption',
              year: '1994',
              actors: 'Morgan Freeman,Tim Robbins',
              posterUrl:
                  'https://static1.moviewebimages.com/wordpress/wp-content/uploads/sharedimages/2024/04/the-shawshank-redemption-movie-poster.jpg', //
            ),

            MovieCard(
              title: 'The Godfather Part II',
              year: '1974',
              actors: 'Al Pacino, 	Robert Duvall',
              posterUrl:
                  'https://www.themoviedb.org/t/p/original/aUPGHP296nsmgKE51ObLzWTXeRv.jpg', // Placeholder image
            ),
            MovieCard(
              title: 'Deadpool & Wolverine',
              year: '2024',
              actors: 'Ryan Reynolds,Hugh Jackman',
              posterUrl:
                  'https://image.tmdb.org/t/p/w500/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg', // Placeholder image
            ),
            MovieCard(
              title: 'crow',
              year: '2022',
              actors: 'Brandon Lee, Bai Ling',
              posterUrl:
                  'https://image.tmdb.org/t/p/w500/58QT4cPJ2u2TqWZkterDq9q4yxQ.jpg', // Placeholder image
            ),

            MovieCard(
              title: 'Us',
              year: '2010',
              actors: 'Rosa Salazar, Christoph Waltz',
              posterUrl:
                  'https://collider.com/wp-content/uploads/2017/06/us-poster.jpg', // Placeholder image
            ),
            MovieCard(
              title: 'The Godfather',
              year: '1972',
              actors: 'Marlon Brando,Diane Keaton',
              posterUrl:
                  'https://collider.com/wp-content/uploads/2017/06/us-poster.jpg', // Placeholder image
            ),

            // Add more MovieCard widgets here as needed
          ],
        ),
      )),
    );
  }
}

class MovieCard extends StatelessWidget {
  final String title;
  final String year;
  final String actors;
  final String posterUrl;

  MovieCard({
    required this.title,
    required this.year,
    required this.actors,
    required this.posterUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      color: Colors.black,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            posterUrl,
            width: 100,
            height: 150,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                year,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              SizedBox(height: 5),
              Text(
                actors,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ],
          ),
          Spacer(),
          Icon(Icons.bookmark_add_rounded, color: Colors.yellow),
        ],
      ),
    );
  }
}
