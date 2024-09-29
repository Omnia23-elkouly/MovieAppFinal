import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:untitled18/screen/test.dart';

import '../app_color.dart';
import '../main.dart';
import '../screen/home_screen.dart';

import '../watchlist/movielist.dart';

class BottomNavBar extends StatelessWidget {
  static const String routeName = 'bottom_nav_bar';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          bottomNavigationBar: Container(
            color: Colors.black26,
            height: 70,
            child: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.home),
                  text: "HOME",
                ),
                Tab(
                  icon: Icon(Icons.search),
                  text: "SEARCH",
                ),
                Tab(
                  icon: Icon(Icons.movie),
                  text: "BROWSE",
                ),
                Tab(
                  icon: Icon(Icons.book),
                  text: "Watchlist",
                ),
              ],
              indicatorColor: Colors.transparent,
              labelColor: AppColors.primaryColor,
              unselectedLabelColor: Color(0xff999999),
            ),
          ),
          body: TabBarView(children: [
            HomeScreen(),
            BlocProvider(
                create: (context) => GenreCubit()..fetchGenres(),
                child: MovieSearchScreen()),
            BlocProvider(
                create: (context) => GenreCubit()..fetchGenres(),
                child: CategoriesScreen()),
            Watchlist()
          ]),
        ));
  }
}
