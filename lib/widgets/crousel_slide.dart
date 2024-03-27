import 'dart:developer';

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
            var url = moviesList.results[index].backdropPath.toString();
            log(url);
            log("$imageUrl$url");
            return GestureDetector(
                child: Column(
              children: [
                CachedNetworkImage(imageUrl: "$imageUrl$url"),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  moviesList.results[index].originalTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ));
          },
          options: CarouselOptions(
            initialPage: 0, // starting pic,
            height: (size.height * 0.33 < 300) ? 300 : size.height * 0.33,
            autoPlay: true, //automatically scrolling
            autoPlayInterval: const Duration(seconds: 10), // after 2 seconds
            reverse: false, // when the pictures are end no reverse,
            aspectRatio: 16 / 9, // screen size,
            autoPlayAnimationDuration:
                const Duration(milliseconds: 800), //how fast should image skip,
            enlargeCenterPage:
                true, //its like padding leaving a gap among pics,
            scrollDirection: Axis.horizontal, // scrolling manually the picture,
          )),
    );
  }
}
