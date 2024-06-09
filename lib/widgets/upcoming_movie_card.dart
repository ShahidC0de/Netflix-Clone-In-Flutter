import 'package:flutter/material.dart';
import 'package:netflix_clone/commons/util.dart';
import 'package:netflix_clone/models/upcoming_movie_model.dart';
import 'package:netflix_clone/screens/movie_details_screen.dart';

class UpcomingMovieCard extends StatefulWidget {
  final Future<UpcomingMovieModel> upcomingMovies;
  final String headlineText;
  const UpcomingMovieCard(
      {super.key, required this.upcomingMovies, required this.headlineText});

  @override
  State<UpcomingMovieCard> createState() => _UpcomingMovieCardState();
}

class _UpcomingMovieCardState extends State<UpcomingMovieCard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.upcomingMovies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data?.results;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.headlineText,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: data!.length,
                        itemBuilder: (context, index) {
                          return Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => DetailsScreen(
                                          movieId: data[index].id),
                                    ),
                                  );
                                },
                                child: Image.network(
                                    "$imageUrl${data[index].posterPath}"),
                              ));
                        }),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
