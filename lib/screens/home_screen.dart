import 'package:flutter/material.dart';
import 'package:netflix_clone/commons/util.dart';
import 'package:netflix_clone/models/top_rated_movie_model.dart';
import 'package:netflix_clone/models/upcoming_movie_model.dart';
import 'package:netflix_clone/screens/search_screen.dart';
import 'package:netflix_clone/services/api_services.dart';
import 'package:netflix_clone/widgets/crousel_slide.dart';
import 'package:netflix_clone/widgets/upcoming_movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiServices apiServices = ApiServices();

  late Future<UpcomingMovieModel> upcomingFuture;
  late Future<UpcomingMovieModel> nowPlayingFuture;
  late Future<TopRatedMovieModel> topratedFuture;

  @override
  void initState() {
    upcomingFuture = apiServices.getUpcomingMovies();
    nowPlayingFuture = apiServices.getNowPlayingMovies();
    topratedFuture = apiServices.getTopRatedMovies();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kbackgroundColor,
          title: Image.asset(
            'assets/logo.png',
            height: 50,
            width: 120,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SearchScreen(),
                    ),
                  );
                },
                child: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                height: 27,
                width: 27,
                color: Colors.blue,
              ),
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                  future: topratedFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return CustomCarousalSlider(moviesList: snapshot.data!);
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
              SizedBox(
                height: 220,
                child: UpcomingMovieCard(
                    upcomingMovies: upcomingFuture,
                    headlineText: "Upcoming Movies"),
              ),
              SizedBox(
                height: 220,
                child: UpcomingMovieCard(
                    upcomingMovies: nowPlayingFuture,
                    headlineText: "Now Playing"),
              ),
            ],
          ),
        ));
  }
}
