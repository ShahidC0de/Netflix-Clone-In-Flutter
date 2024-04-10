import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/commons/util.dart';
import 'package:netflix_clone/models/movie_detail_model.dart';
import 'package:netflix_clone/models/recommend_movie_model.dart';
import 'package:netflix_clone/services/api_services.dart';

class DetailsScreen extends StatefulWidget {
  final int movieId;
  const DetailsScreen({super.key, required this.movieId});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() {
    movieDetails = apiServices.getMovieDetails(widget.movieId);
    recommendedMovies = apiServices.getrecommendedMovies(widget.movieId);
    setState(() {});
  }

  late Future<MovieDetailModel> movieDetails;
  late Future<RecommendMovieModel> recommendedMovies;
  ApiServices apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: movieDetails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final details = snapshot.data;
              String genreText =
                  details!.genres.map((genre) => genre.name).join(',');
              return Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              "$imageUrl${details.posterPath}",
                            ),
                          ),
                        ),
                        child: SafeArea(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(details.originalTitle),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          details.releaseDate.year.toString(),
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(
                          genreText,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      details.overview,
                      maxLines: 7,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FutureBuilder(
                      future: recommendedMovies,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final recommendedMovie = snapshot.data!;
                          return recommendedMovie.results.isEmpty
                              ? const SizedBox()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("More like this"),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    GridView.builder(
                                        itemCount:
                                            recommendedMovie.results.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          mainAxisSpacing: 15,
                                          childAspectRatio: 1.5 / 2,
                                          crossAxisSpacing: 5,
                                        ),
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailsScreen(
                                                          movieId:
                                                              recommendedMovie
                                                                  .results[
                                                                      index]
                                                                  .id),
                                                ),
                                              );
                                            },
                                            child: CachedNetworkImage(
                                                imageUrl:
                                                    "$imageUrl${recommendedMovie.results[index].posterPath}"),
                                          );
                                        }),
                                  ],
                                );
                        } else {
                          return const SizedBox();
                        }
                      })
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
