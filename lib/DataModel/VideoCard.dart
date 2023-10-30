class VideoCard {
  final String thumbnailURL;
  final String title;
  final String channelTitle;
  final String publishTime;
  final String linkURL;
  final String type;

  VideoCard({
    required this.thumbnailURL,
    required this.title,
    required this.channelTitle,
    required this.publishTime,
    required this.linkURL,
    required this.type,
  });

  // Helper method to get the formatted type (e.g., "View Playlist" or "View Video")
  String get typeForamatted => "View ${type[0].toUpperCase()}${type.substring(1)}";
}
