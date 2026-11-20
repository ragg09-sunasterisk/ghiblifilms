import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ghiblifilms/features/films/data/repositories/film_repository_impl.dart';
import 'package:ghiblifilms/features/films/data/repositories/watched_repository.dart';
import 'package:ghiblifilms/features/films/data/services/film_service.dart';
import 'package:ghiblifilms/features/films/model/film.dart';
import 'package:ghiblifilms/features/films/ui/view_models/film_detail_view_model.dart';
import 'package:ghiblifilms/features/films/ui/view_models/film_list_view_model.dart';
import 'package:ghiblifilms/features/films/ui/views/film_detail_view.dart';
import 'package:ghiblifilms/features/films/ui/views/film_list_view.dart';

void main() {
  // Dependency wiring. This is the only place that knows every class.
  final service = FilmService(client: http.Client());
  final filmRepository = FilmRepositoryImpl(service: service);
  final watchedRepository = WatchedRepository();
  final listViewModel = FilmListViewModel(
    filmRepository: filmRepository,
    watchedRepository: watchedRepository,
  );

  runApp(
    GhibliApp(
      listViewModel: listViewModel,
      watchedRepository: watchedRepository,
    ),
  );
}

class GhibliApp extends StatelessWidget {
  final FilmListViewModel listViewModel;
  final WatchedRepository watchedRepository;

  const GhibliApp({
    super.key,
    required this.listViewModel,
    required this.watchedRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ghibli Films',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.teal),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute<void>(
              settings: settings,
              builder: (_) => FilmListView(viewModel: listViewModel),
            );
          case '/detail':
            final film = settings.arguments as Film;
            return MaterialPageRoute<void>(
              settings: settings,
              builder: (_) => FilmDetailView(
                viewModel: FilmDetailViewModel(
                  film: film,
                  watchedRepository: watchedRepository,
                ),
              ),
            );
          default:
            return null;
        }
      },
    );
  }
}
