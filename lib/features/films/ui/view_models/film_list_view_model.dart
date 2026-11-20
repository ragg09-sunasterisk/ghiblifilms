import 'package:flutter/foundation.dart';
import 'package:ghiblifilms/core/utils/result.dart';
import 'package:ghiblifilms/features/films/data/repositories/film_repository.dart';
import 'package:ghiblifilms/features/films/data/repositories/watched_repository.dart';
import 'package:ghiblifilms/features/films/model/film.dart';

enum FilmListStatus { loading, success, error }

class FilmListViewModel extends ChangeNotifier {
  FilmListViewModel({
    required FilmRepository filmRepository,
    required WatchedRepository watchedRepository,
  }) : _filmRepository = filmRepository,
       _watchedRepository = watchedRepository {
    // When a film is marked as watched anywhere, rebuild this screen too.
    _watchedRepository.addListener(notifyListeners);
  }

  final FilmRepository _filmRepository;
  final WatchedRepository _watchedRepository;

  FilmListStatus _status = FilmListStatus.loading;
  List<Film> _films = [];
  String _query = '';
  String _errorMessage = '';

  FilmListStatus get status => _status;
  String get errorMessage => _errorMessage;
  String get query => _query;
  int get totalCount => _films.length;
  int get watchedCount => _watchedRepository.count;

  /// Films after the search filter is applied.
  List<Film> get visibleFilms {
    final text = _query.trim().toLowerCase();
    if (text.isEmpty) return _films;

    return _films.where((film) {
      return film.title.toLowerCase().contains(text) ||
          film.director.toLowerCase().contains(text);
    }).toList();
  }

  bool isWatched(String filmId) => _watchedRepository.isWatched(filmId);

  Future<void> loadFilms() async {
    _status = FilmListStatus.loading;
    notifyListeners();

    final result = await _filmRepository.getFilms();

    switch (result) {
      case Success(:final data):
        _films = data;
        _status = FilmListStatus.success;
      case Failed(:final failure):
        _errorMessage = failure.message;
        _status = FilmListStatus.error;
    }

    notifyListeners();
  }

  void setQuery(String value) {
    _query = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _watchedRepository.removeListener(notifyListeners);
    super.dispose();
  }
}
