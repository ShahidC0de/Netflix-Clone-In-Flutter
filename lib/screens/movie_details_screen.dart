import 'package:flutter/material.dart';
import 'package:netflix_clone/commons/util.dart';
import 'package:netflix_clone/models/movie_detail_model.dart';
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
    setState(() {});
  }

  late Future<MovieDetailModel> movieDetails;
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [Text(details.originalTitle)],
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
                    )
                  ],
                );
              } else {
                return const SizedBox();
              }
            }),
      ),
    );
  }
}
