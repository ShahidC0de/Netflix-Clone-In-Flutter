import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/commons/util.dart';
import 'package:netflix_clone/models/search_movie_model.dart';
import 'package:netflix_clone/services/api_services.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ApiServices apiServices = ApiServices();
  TextEditingController textController = TextEditingController();
  SearchMovieModel? searchMovieModel;
  void performSearch(String search) {
    apiServices.getSearchedMovies(search).then((_result) {
      setState(() {
        searchMovieModel = _result;
      });
    });
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
              const SizedBox(
                height: 20,
              ),
              searchMovieModel == null
                  ? const SizedBox.shrink()
                  : GridView.builder(
                      itemCount: searchMovieModel?.results.length,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 5,
                      ),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  "$imageUrl${searchMovieModel!.results[index].backdropPath}",
                              height: 170,
                            ),
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
