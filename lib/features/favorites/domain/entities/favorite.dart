class Favorite {
  final String id; // itemId
  final String title;
  final String subtitle;
  final String imageUrl;
  final String color;
  final String type; // 'session' or 'track'

  Favorite({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.color,
    required this.type,
  });
}
