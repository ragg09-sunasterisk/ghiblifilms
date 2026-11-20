import 'package:flutter/material.dart';
import 'package:ghiblifilms/features/films/ui/view_models/film_detail_view_model.dart';
import 'package:ghiblifilms/features/films/ui/widgets/film_image.dart';

class FilmDetailView extends StatelessWidget {
  final FilmDetailViewModel viewModel;

  const FilmDetailView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final film = viewModel.film;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(film.title)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FilmImage(url: film.bannerUrl, width: double.infinity, height: 200),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: 'poster-${film.id}',
                        child: FilmImage(
                          url: film.imageUrl,
                          width: 100,
                          height: 150,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              film.title,
                              style: textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (film.originalTitle.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(
                                film.originalTitle,
                                style: textTheme.titleSmall?.copyWith(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                            const SizedBox(height: 12),
                            Text('Director: ${film.director}'),
                            const SizedBox(height: 2),
                            Text('Producer: ${film.producer}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _InfoItem(
                        icon: Icons.calendar_today,
                        label: '${film.releaseYear}',
                      ),
                      _InfoItem(
                        icon: Icons.schedule,
                        label: film.durationLabel,
                      ),
                      _InfoItem(icon: Icons.star, label: '${film.rtScore}%'),
                    ],
                  ),
                  const Divider(height: 32),
                  Text('Synopsis', style: textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text(film.description),
                  const SizedBox(height: 24),
                  ListenableBuilder(
                    listenable: viewModel,
                    builder: (context, _) {
                      final watched = viewModel.isWatched;

                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: viewModel.toggleWatched,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: watched ? Colors.green : null,
                            foregroundColor: watched ? Colors.white : null,
                          ),
                          icon: Icon(watched ? Icons.check_circle : Icons.add),
                          label: Text(viewModel.watchButtonLabel),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.teal),
        const SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}
