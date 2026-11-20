import 'package:flutter/foundation.dart';

/// The single source of truth for which films the user has watched.
///
/// Both ViewModels read from this one object, so a change made on the
/// detail screen shows up on the list screen without passing results
/// back through the Navigator. It lives in memory only, so it resets
/// when the app closes.
class WatchedRepository extends ChangeNotifier {
  final Set<String> _watchedIds = {};

  int get count => _watchedIds.length;

  bool isWatched(String filmId) => _watchedIds.contains(filmId);

  void setWatched(String filmId, bool watched) {
    final changed = watched
        ? _watchedIds.add(filmId)
        : _watchedIds.remove(filmId);
    if (changed) notifyListeners();
  }
}
