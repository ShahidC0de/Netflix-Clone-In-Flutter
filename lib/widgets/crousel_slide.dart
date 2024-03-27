import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/commons/util.dart';
import 'package:netflix_clone/models/top_rated_movie_model.dart';

class CustomCarousalSlider extends StatelessWidget {
  final TopRatedMovieModel moviesList;
  const CustomCarousalSlider({super.key, required this.moviesList});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: (size.height * 0.33 < 300) ? 300 : size.height * 0.33,
      child: CarouselSlider.builder(
          itemCount: moviesList.results.length,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            var url = moviesList.results[index].posterPath.toString();
            return GestureDetector(
                child: CachedNetworkImage(imageUrl: "$imageUrl$url"));
          },
          options: CarouselOptions()),
    );
  }
}
