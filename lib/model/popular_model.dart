class PopularModel {
  String? backdropPath;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  double? voteAverage;
  int? voteCount;

  PopularModel({
    this.backdropPath,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.voteAverage,
    this.voteCount,
  });


  factory PopularModel.fromMap(Map<String,dynamic> movie){
    return PopularModel(
      id:movie['id'],
      backdropPath:movie['backdrop_path'],
      posterPath:movie['poster_path'],
      originalLanguage:movie['original_language'],
      originalTitle:movie['original_title'],
      overview:movie['overview'],
      popularity:movie['popularity'],
      releaseDate:movie['release_data'],
      title:movie['title'],
      voteAverage:movie['vote_average'],
      voteCount:movie['vote_count'],
    );
  }
}