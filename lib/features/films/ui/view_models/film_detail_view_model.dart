import 'package:flutter/foundation.dart';
import 'package:ghiblifilms/features/films/data/repositories/watched_repository.dart';
import 'package:ghiblifilms/features/films/model/film.dart';

class FilmDetailViewModel extends ChangeNotifier {
  FilmDetailViewModel({
    required this.film,
    required WatchedRepository watchedRepository,
  }) : _watchedRepository = watchedRepository;

  final Film film;
  final WatchedRepository _watchedRepository;

  bool get isWatched => _watchedRepository.isWatched(film.id);

  String get watchButtonLabel => isWatched ? 'Watched' : 'Mark as watched';

  void toggleWatched() {
    _watchedRepository.setWatched(film.id, !isWatched);
    notifyListeners();
  }
}
