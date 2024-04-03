import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:netflix_clone/commons/util.dart';
import 'package:netflix_clone/models/popular_movies_model.dart';
import 'package:netflix_clone/models/search_movie_model.dart';
import 'package:netflix_clone/models/top_rated_movie_model.dart';
import 'package:netflix_clone/services/api_services.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ApiServices apiServices = ApiServices();
  TextEditingController textController = TextEditingController();
  late Future<TopRatedMovieModel> popularMovies;
  SearchMovieModel? searchMovieModel;
  void performSearch(String search) {
    apiServices.getSearchedMovies(search).then((result) {
      setState(() {
        searchMovieModel = result;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    popularMovies = apiServices.getTopRatedMovies();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              CupertinoSearchTextField(
                controller: textController,
                padding: const EdgeInsets.all(10),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                suffixIcon: const Icon(
                  Icons.cancel,
                ),
                style: const TextStyle(
                  color: Colors.white,
                ),
                backgroundColor: Colors.grey.withOpacity(0.3),
                onChanged: (value) {
                  if (value.isEmpty) {
                  } else {
                    performSearch(textController.text);
                  }
                },
              ),
              textController.text.isEmpty
                  ? FutureBuilder(
                      future: popularMovies,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var data = snapshot.data?.results;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "Top Searches",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: data!.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                          height: 150,
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: Row(
                                            children: [
                                              Image.network(
                                                "$imageUrl${data[index].posterPath}",
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              SizedBox(
                                                width: 250,
                                                child: Text(
                                                  data[index].title,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ));
                                    }),
                              ],
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      })
                  : const SizedBox(
                      height: 20,
                    ),
              searchMovieModel == null
                  ? const SizedBox.shrink()
                  : GridView.builder(
                      itemCount: searchMovieModel?.results.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1.2 / 2,
                      ),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            // ignore: unnecessary_null_comparison
                            searchMovieModel!.results[index].backdropPath ==
                                    null
                                ? Image.asset(
                                    "netflix.png",
                                    height: 170,
                                  )
                                : CachedNetworkImage(
                                    imageUrl:
                                        "$imageUrl${searchMovieModel!.results[index].backdropPath}",
                                    height: 170,
                                  ),
                            SizedBox(
                              width: 100,
                              child: Text(
                                searchMovieModel!.results[index].originalTitle,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            )
                          ],
                        );
                      })
            ],
          ),
        ),
      ),
    );
  }
}
