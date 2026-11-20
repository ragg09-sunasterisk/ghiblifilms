import 'package:flutter/material.dart';

/// A network image that shows a placeholder icon when loading fails.
class FilmImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;

  const FilmImage({
    super.key,
    required this.url,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: const Icon(Icons.broken_image, color: Colors.grey),
        );
      },
    );
  }
}
