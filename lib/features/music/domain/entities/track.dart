class Track {
  final String id;
  final String title;
  final String author;
  final String audioUrl;
  final String imageUrl;
  final int duration; // Duration in total seconds

  Track({
    required this.id,
    required this.title,
    required this.author,
    required this.audioUrl,
    required this.imageUrl,
    required this.duration,
  });
}

