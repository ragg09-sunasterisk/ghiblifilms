import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ghiblifilms/features/films/ui/view_models/film_list_view_model.dart';
import 'package:ghiblifilms/features/films/ui/widgets/error_view.dart';
import 'package:ghiblifilms/features/films/ui/widgets/film_card.dart';

class FilmListView extends StatefulWidget {
  final FilmListViewModel viewModel;

  const FilmListView({super.key, required this.viewModel});

  @override
  State<FilmListView> createState() => _FilmListViewState();
}

class _FilmListViewState extends State<FilmListView> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.loadFilms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ghibli Films'),
        centerTitle: true,
        actions: [
          ListenableBuilder(
            listenable: widget.viewModel,
            builder: (context, _) {
              final viewModel = widget.viewModel;
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Center(
                  child: Text(
                    '${viewModel.watchedCount}/${viewModel.totalCount}',
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              onChanged: widget.viewModel.setQuery,
              decoration: InputDecoration(
                hintText: 'Search by title or director',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListenableBuilder(
              listenable: widget.viewModel,
              builder: (context, _) {
                final viewModel = widget.viewModel;

                return switch (viewModel.status) {
                  FilmListStatus.loading => const Center(
                    child: SpinKitFadingCircle(color: Colors.teal, size: 50),
                  ),
                  FilmListStatus.error => ErrorView(
                    message: viewModel.errorMessage,
                    onRetry: viewModel.loadFilms,
                  ),
                  FilmListStatus.success => _buildFilmList(viewModel),
                };
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilmList(FilmListViewModel viewModel) {
    final films = viewModel.visibleFilms;

    if (films.isEmpty) {
      return Center(
        child: Text(
          viewModel.query.isEmpty
              ? 'No films available'
              : 'No films match "${viewModel.query}"',
        ),
      );
    }

    return ListView.builder(
      itemCount: films.length,
      itemBuilder: (context, index) {
        final film = films[index];
        return FilmCard(
          film: film,
          watched: viewModel.isWatched(film.id),
          onTap: () {
            Navigator.pushNamed(context, '/detail', arguments: film);
          },
        );
      },
    );
  }
}
