import 'package:flutter/material.dart';
import 'package:ghiblifilms/features/films/ui/view_models/film_list_view_model.dart';
import 'package:ghiblifilms/features/films/ui/views/film_list_view.dart';
import 'package:http/http.dart' as http;
import 'package:ghiblifilms/features/films/data/repositories/film_repository_impl.dart';
import 'package:ghiblifilms/features/films/data/repositories/watched_repository.dart';
import 'package:ghiblifilms/features/films/data/services/film_service.dart';

void main() {
  // Dependency wiring. This is the only place that knows every class.
  final service = FilmService(client: http.Client());
  final filmRepository = FilmRepositoryImpl(service: service);
  final watchedRepository = WatchedRepository();
  final listViewModel = FilmListViewModel(
    filmRepository: filmRepository,
    watchedRepository: watchedRepository,
  );

  runApp(GhibliApp(listViewModel: listViewModel));
}

class GhibliApp extends StatelessWidget {
  final FilmListViewModel listViewModel;

  const GhibliApp({super.key, required this.listViewModel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ghibli Films',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.teal),
      home: FilmListView(viewModel: listViewModel),
    );
  }
}
