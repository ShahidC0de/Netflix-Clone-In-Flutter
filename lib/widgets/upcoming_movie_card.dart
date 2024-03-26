import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:netflix_clone/commons/util.dart';
import 'package:netflix_clone/models/upcoming_movie_model.dart';

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
          var data = snapshot.data?.results;
          return Column(
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
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image.network(
                              "$imageUrl${data[index].posterPath}"));
                    }),
              ),
            ],
          );
        });
  }
}
