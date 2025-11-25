import 'package:flutter/material.dart';
import 'package:nonton/models/movie.dart';
import 'package:nonton/screens/login_page.dart';
import 'package:nonton/screens/home_page.dart';
import 'package:nonton/screens/detail_page.dart';
import 'package:nonton/screens/profile_page.dart';
import 'package:nonton/screens/search_page.dart';

void main() => runApp(const NetflixCloneApp());

class NetflixCloneApp extends StatelessWidget {
  const NetflixCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nonton - Netflix Clone',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (_) => const LoginPage(),
        '/home': (_) => const HomePage(),
        '/profile': (_) => const ProfilePage(),
        '/search': (_) => const SearchPage(),
      },
    
      onGenerateRoute: (settings) {
        if (settings.name == '/detail') {
          final movie = settings.arguments as Movie;
          return MaterialPageRoute(
            builder: (_) => MovieDetailPage(movie: movie),
          );
        }
        return null;
      },
    );
  }
}
