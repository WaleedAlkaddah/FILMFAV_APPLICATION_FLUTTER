class get_popular_data {
  final String id;
  final String original_title;
  final String overview;
  final String posterPath;
  final String original_language;
  final String popularity;
  final String vote_average;
  final String release_date;
  final String backdrop_path;

  get_popular_data({
    required this.id,
    required this.original_title,
    required this.overview,
    required this.posterPath,
    required this.original_language,
    required this.popularity,
    required this.vote_average,
    required this.release_date,
    required this.backdrop_path,
  });

  factory get_popular_data.fromJson(Map<String, dynamic> json) {
    return get_popular_data(
      id: json['id'].toString(),
      original_title: json['original_title'],
      overview: json['overview'],
      original_language: json['original_language'],
      popularity: json['popularity'].toString(),
      release_date: json['release_date'],
      vote_average: json['vote_average'].toString(),
      posterPath: json['poster_path']?.toString()??"",
      backdrop_path: json['backdrop_path']?.toString()??"",
    );
  }
}
