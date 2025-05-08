import 'package:flutter/material.dart';
import '../../../logic/movies/models/movies_models.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;
  const MovieDetailScreen({super.key, required this.movie});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  int selectedImageIndex = 0;
  bool showFullscreen = false;

  @override
  Widget build(BuildContext context) {
    final bool inFullscreen = showFullscreen;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor:
            inFullscreen ? const Color.fromARGB(255, 6, 6, 6) : Colors.white,
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 50,
        title: Text(
          widget.movie.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: inFullscreen ? Colors.white : Colors.black,
          ),
        ),
        iconTheme: IconThemeData(
          color: inFullscreen ? Colors.white : Colors.black,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            //padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Großes Poster
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.movie.poster,
                      height: 500,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) =>
                              const Icon(Icons.broken_image, size: 100),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MovieInfo(label: "Genre", value: widget.movie.genre),
                      MovieInfo(label: "Year", value: widget.movie.year),
                      MovieInfo(
                        label: "Director",
                        value: widget.movie.director,
                      ),
                      MovieInfo(label: "Actors", value: widget.movie.actors),
                      MovieInfo(label: "Runtime", value: widget.movie.runtime),
                      MovieInfo(
                        label: "IMDb Rating",
                        value: widget.movie.imdbRating,
                      ),
                      MovieInfo(label: "Awards", value: widget.movie.awards),
                      MovieInfo(
                        label: "Language",
                        value: widget.movie.language,
                      ),
                      MovieInfo(label: "Country", value: widget.movie.country),

                      const SizedBox(height: 20),

                      const Text(
                        "Plot",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.movie.plot,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                if (widget.movie.images.isNotEmpty) ...[
                  Center(
                    child: const Text(
                      "More Images",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),
                  SizedBox(
                    height: 200,
                    child: PageView.builder(
                      itemCount: widget.movie.images.length,
                      controller: PageController(viewportFraction: 0.7),
                      onPageChanged:
                          (index) => setState(() => selectedImageIndex = index),
                      itemBuilder: (context, index) {
                        final isFocused = index == selectedImageIndex;
                        return GestureDetector(
                          onTap: () => setState(() => showFullscreen = true),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                if (isFocused)
                                  BoxShadow(
                                    color: const Color.fromARGB(57, 0, 0, 0),
                                    //blurRadius: 20,
                                    //spreadRadius: 5,
                                    //offset: const Offset(0, 10),
                                  ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                widget.movie.images[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ],
            ),
          ),

          if (showFullscreen)
            Positioned.fill(
              child: Container(
                color: const Color.fromARGB(235, 0, 0, 0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.network(
                      widget.movie.images[selectedImageIndex],
                      fit: BoxFit.contain,
                    ),
                    Positioned(
                      top: 200,
                      right: 20,
                      child: IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () => setState(() => showFullscreen = false),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed:
                            () => setState(() {
                              if (selectedImageIndex > 0) selectedImageIndex--;
                            }),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                        onPressed:
                            () => setState(() {
                              if (selectedImageIndex <
                                  widget.movie.images.length - 1) {
                                selectedImageIndex++;
                              }
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class MovieInfo extends StatelessWidget {
  final String label;
  final String value;

  const MovieInfo({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 16, color: Colors.black87),
          children: [
            TextSpan(
              text: "$label: ",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
