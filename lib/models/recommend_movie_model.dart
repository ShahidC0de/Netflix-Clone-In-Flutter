class RecommendMovieModel {
  final int page;
  final List<Result> results;
  final int totalPages;
  final int totalResults;

  RecommendMovieModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory RecommendMovieModel.fromJson(Map<String, dynamic> json) {
    return RecommendMovieModel(
      page: json['page'],
      results:
          List<Result>.from(json['results'].map((x) => Result.fromJson(x))),
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }
}

class Result {
  final bool adult;
  final String backdropPath;
  final int id;
  final String title;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final MediaType mediaType;
  final List<int> genreIds;
  final double popularity;
  final DateTime releaseDate;
  final bool video;
  final double voteAverage;
  final int voteCount;

  Result({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.title,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.genreIds,
    required this.popularity,
    required this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      id: json['id'],
      title: json['title'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      mediaType: mediaTypeValues.map[json['media_type']]!,
      genreIds: List<int>.from(json['genre_ids'].map((x) => x)),
      popularity: json['popularity'],
      releaseDate: DateTime.parse(json['release_date']),
      video: json['video'],
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
    );
  }
}

enum MediaType {
  MOVIE,
}

final mediaTypeValues = EnumValues({
  "movie": MediaType.MOVIE,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
