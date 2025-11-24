class Movie {
  final String id;
  final String title;
  final String overview;
  final String posterUrl;
  final String backdropUrl;
  final double rating;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterUrl,
    required this.backdropUrl,
    required this.rating,
  });
}

final List<Movie> mockMovies = List.generate(12, (i) {
  final id = (i + 1).toString();
  return Movie(
    id: id,
    title: 'Movie Title $id',
    overview:
        'Deskripsi singkat untuk Movie Title $id. Teks ini hanya contoh.',
    posterUrl: 'https://picsum.photos/200/300?random=${i + 10}',
    backdropUrl: 'https://picsum.photos/800/400?random=${i + 100}',
    rating: 6.5 + (i % 4),
  );
});
