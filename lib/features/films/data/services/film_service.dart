import 'dart:convert';

import 'package:ghiblifilms/core/error/exceptions.dart';
import 'package:ghiblifilms/features/films/model/film.dart';
import 'package:http/http.dart' as http;

class FilmService {
  final http.Client client;

  const FilmService({required this.client});

  static const _filmsUrl = 'https://ghibliapi.vercel.app/films';

  Future<List<Film>> fetchFilms() async {
    final http.Response response;

    try {
      response = await client
          .get(Uri.parse(_filmsUrl))
          .timeout(const Duration(seconds: 10));
    } catch (_) {
      // No internet, DNS failure or timeout.
      throw NetworkExceptions();
    }

    if (response.statusCode != 200) {
      throw ServerException();
    }

    final List<dynamic> json = jsonDecode(response.body) as List<dynamic>;
    return json
        .map((item) => Film.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
