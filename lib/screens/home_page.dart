import 'package:flutter/material.dart';
import '../models/movie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double appBarOpacity = 0;
  final ScrollController _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _scroll.addListener(() {
      double offset = _scroll.offset;
      double opacity = (offset / 200).clamp(0, 1);
      setState(() => appBarOpacity = opacity);
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Container(
          color: Colors.black.withOpacity(appBarOpacity),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "NETFLIX",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              Row(
                children: const [
                  Icon(Icons.collections_bookmark, color: Colors.white),
                  SizedBox(width: 16),
                  Icon(Icons.search, color: Colors.white),
                ],
              )
            ],
          ),
        ),
      ),
      body: ListView(
        controller: _scroll,
        children: [
          // HERO
          Stack(
            children: [
              SizedBox(
                height: 430,
                child: Image.network(
                  mockMovies[0].backdropUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.9),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 35,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      mockMovies[0].title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        shadows: [Shadow(blurRadius: 8, color: Colors.black)],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: const [
                            Icon(Icons.add, color: Colors.white),
                            SizedBox(height: 4),
                            Text("My List", style: TextStyle(color: Colors.white)),
                          ],
                        ),
                        const SizedBox(width: 30),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/detail', arguments: mockMovies[0]);
                          },
                          icon: const Icon(Icons.play_arrow),
                          label: const Text("Play"),
                        ),
                        const SizedBox(width: 30),
                        Column(
                          children: const [
                            Icon(Icons.info_outline, color: Colors.white),
                            SizedBox(height: 4),
                            Text("Info", style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          buildCategory(title: "Trending Now", movies: mockMovies, context: context),
          buildTop10(context),
          buildCategory(title: "Popular on Netflix", movies: mockMovies.reversed.toList(), context: context),
          buildCategory(title: "Recommended For You", movies: mockMovies, context: context),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget buildCategory({
    required String title,
    required List<Movie> movies,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600)),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 155,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (_, i) {
              final movie = movies[i];
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/detail', arguments: movie),
                child: Container(
                  width: 110,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(movie.posterUrl, fit: BoxFit.cover),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget buildTop10(BuildContext context) {
    final movies = mockMovies.take(10).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text("Top 10 in Indonesia Today", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600))
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (_, index) {
              final movie = movies[index];
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/detail', arguments: movie),
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      margin: const EdgeInsets.only(left: 25, right: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(movie.posterUrl, fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(
                          fontSize: 90,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade900,
                          shadows: const [Shadow(blurRadius: 6, color: Colors.black)],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
