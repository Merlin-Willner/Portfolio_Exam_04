import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/movies/bloc/movies_bloc.dart';
//import '../../logic/movies/models/movies_models.dart';
import 'custom_movie_list_item.dart';

class ShowMoviesWidget extends StatefulWidget {
  const ShowMoviesWidget({super.key});

  @override
  State<ShowMoviesWidget> createState() => _ShowMoviesWidgetState();
}

class _ShowMoviesWidgetState extends State<ShowMoviesWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      bloc: BlocProvider.of<MoviesBloc>(context)..add(RequestToLoadAllMovies()),
      builder: (context, state) {
        return switch (state) {
          LoadingMovies() => const Center(child: CircularProgressIndicator()),
          MoviesLoaded() => ListView.builder(
            itemCount: state.movies.length,
            //prototypeItem: ListTile(
            //  title: Text(state.movies.first.title),
            //  subtitle: Text(state.movies.first.director),
            //),
            itemBuilder: (context, index) {
              return CustomListItem(movie: state.movies[index]);
              //ListTile(
              //  title: Text(state.movies[index].title),
              //  subtitle: Text(state.movies[index].director),
              //);
            },
          ),
          _ => const Placeholder(),
        };
      },
    );
  }
}
