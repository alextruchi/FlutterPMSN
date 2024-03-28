class ReviewsMovieModel {
  final String id;
  final String autor;
  final String contenido;
  
  ReviewsMovieModel({
    required this.id,
    required this.autor,
    required this.contenido,
  });

  factory ReviewsMovieModel.fromMap(Map<String, dynamic> review) {
    return ReviewsMovieModel(
      id: review['id'].toString(),
      autor: review['author'],
      contenido: review['content'],
    );
  }
}