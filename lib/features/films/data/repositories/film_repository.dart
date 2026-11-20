import 'package:ghiblifilms/core/utils/result.dart';
import 'package:ghiblifilms/features/films/model/film.dart';

abstract class FilmRepository {
  Future<Result<List<Film>>> getFilms();
}
