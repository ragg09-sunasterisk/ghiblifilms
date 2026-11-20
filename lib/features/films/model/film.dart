class Film {
  final String id;
  final String title;
  final String originalTitle;
  final String description;
  final String director;
  final String producer;
  final String imageUrl;
  final String bannerUrl;
  final int releaseYear;
  final int runningTime; // minutes
  final int rtScore; // Rotten Tomatoes score, 0 to 100

  const Film({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.description,
    required this.director,
    required this.producer,
    required this.imageUrl,
    required this.bannerUrl,
    required this.releaseYear,
    required this.runningTime,
    required this.rtScore,
  });

  factory Film.fromJson(Map<String, dynamic> json) {
    return Film(
      id: json['id'] as String,
      title: json['title'] as String,
      originalTitle: _asString(json['original_title']),
      description: _asString(json['description']),
      director: _asString(json['director']),
      producer: _asString(json['producer']),
      imageUrl: _asString(json['image']),
      bannerUrl: _asString(json['movie_banner']),
      releaseYear: _asInt(json['release_date']),
      runningTime: _asInt(json['running_time']),
      rtScore: _asInt(json['rt_score']),
    );
  }

  /// Running time as text, for example "2h 5m".
  String get durationLabel {
    if (runningTime == 0) return 'Unknown';
    final hours = runningTime ~/ 60;
    final minutes = runningTime % 60;
    return hours > 0 ? '${hours}h ${minutes}m' : '${minutes}m';
  }

  static String _asString(dynamic value) => value?.toString() ?? '';

  static int _asInt(dynamic value) {
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}
