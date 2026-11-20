import 'package:ghiblifilms/core/error/exceptions.dart';
import 'package:ghiblifilms/core/error/failures.dart';
import 'package:ghiblifilms/core/utils/result.dart';
import 'package:ghiblifilms/features/films/data/repositories/film_repository.dart';
import 'package:ghiblifilms/features/films/data/services/film_service.dart';
import 'package:ghiblifilms/features/films/model/film.dart';

class FilmRepositoryImpl implements FilmRepository {
  final FilmService service;

  const FilmRepositoryImpl({required this.service});

  @override
  Future<Result<List<Film>>> getFilms() async {
    try {
      final films = await service.fetchFilms();
      return Success<List<Film>>(films);
    } on NetworkExceptions {
      return const Failed<List<Film>>(NetworkFailure());
    } on ServerException {
      return const Failed<List<Film>>(ServerFailure());
    } catch (_) {
      // For example, JSON that is not shaped the way the model expects.
      return const Failed<List<Film>>(UnknownFailure());
    }
  }
}
