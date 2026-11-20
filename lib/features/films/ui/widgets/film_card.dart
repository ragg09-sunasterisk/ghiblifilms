import 'package:flutter/material.dart';
import 'package:ghiblifilms/features/films/model/film.dart';
import 'package:ghiblifilms/features/films/ui/widgets/film_image.dart';

class FilmCard extends StatelessWidget {
  final Film film;
  final bool watched;
  final VoidCallback onTap;

  const FilmCard({
    super.key,
    required this.film,
    required this.watched,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'poster-${film.id}',
              child: FilmImage(url: film.imageUrl, width: 100, height: 150),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      film.title,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${film.releaseYear} - ${film.durationLabel}',
                      style: textTheme.bodySmall,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Directed by ${film.director}',
                      style: textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text('${film.rtScore}%'),
                        const Spacer(),
                        if (watched)
                          const Chip(
                            avatar: Icon(Icons.check, size: 16),
                            label: Text('Watched'),
                            visualDensity: VisualDensity.compact,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
