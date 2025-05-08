import 'package:flutter/material.dart';
import '../../logic/movies/models/movies_models.dart';
import '../screens/movie_details_screen.dart';

class CustomListItem extends StatelessWidget {
  final Movie movie;

  const CustomListItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MovieDetailScreen(movie: movie),
          ),
        );
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Posterbild links
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  movie.poster,
                  width: 100,
                  height: 150,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) => Container(
                        width: 100,
                        height: 150,
                        color: Colors.grey[300],
                        child: const Icon(Icons.broken_image, size: 40),
                      ),
                ),
              ),
              const SizedBox(width: 16),

              // Info rechts
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text("🎬 ${movie.genre}"),
                    Text("📅 ${movie.year}"),
                    Text("🎥 Directed by ${movie.director}"),
                    Text("⭐ IMDb: ${movie.imdbRating}"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
