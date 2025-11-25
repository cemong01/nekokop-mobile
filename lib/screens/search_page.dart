import 'package:flutter/material.dart';
import '../models/movie.dart'; // Import model film
import 'detail_page.dart'; // Import halaman detail

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Movie> _filteredMovies = []; // Daftar hasil pencarian

  @override
  void initState() {
    super.initState();
    // Inisialisasi dengan daftar film lengkap,
    // atau biarkan kosong jika ingin pengguna mengetik dulu
    _filteredMovies = mockMovies; 
    _searchController.addListener(_filterMovies);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Logika untuk memfilter film
  void _filterMovies() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      if (query.isEmpty) {
        // Jika kueri kosong, tampilkan semua atau kosongkan
        _filteredMovies = mockMovies; 
      } else {
        _filteredMovies = mockMovies.where((movie) {
          // Mencocokkan judul film
          return movie.title.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        // TextField sebagai judul AppBar untuk input pencarian
        title: TextField(
          controller: _searchController,
          autofocus: true,
          style: const TextStyle(color: Colors.white, fontSize: 18),
          decoration: InputDecoration(
            hintText: 'Cari film, acara TV, genre...',
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
            suffixIcon: _searchController.text.isNotEmpty 
                ? IconButton(
                    icon: const Icon(Icons.clear, color: Colors.white),
                    onPressed: () {
                      _searchController.clear();
                      _filterMovies();
                    },
                  )
                : null,
          ),
        ),
      ),
      body: _filteredMovies.isEmpty && _searchController.text.isNotEmpty
          ? const Center(
              child: Text(
                "Tidak ada hasil ditemukan.",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: _filteredMovies.length,
              itemBuilder: (context, index) {
                final movie = _filteredMovies[index];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      movie.posterUrl,
                      width: 50,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(movie.title, style: const TextStyle(color: Colors.white)),
                  subtitle: Text(
                    'Rating: ${movie.rating}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  trailing: const Icon(Icons.play_arrow, color: Colors.white),
                  onTap: () {
                    // Navigasi ke halaman detail
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailPage(movie: movie),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}