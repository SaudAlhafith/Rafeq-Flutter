class VideoCard {
  final String id;

  final String thumbnailURL;
  final String title;
  final String channelTitle;
  final String publishTime;
  final String linkURL;
  final String type;

  VideoCard({
    required this.id,
    required this.thumbnailURL,
    required this.title,
    required this.channelTitle,
    required this.publishTime,
    required this.linkURL,
    required this.type,
  });

  // Convert VideoCard instance to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'thumbnailURL': thumbnailURL,
      'title': title,
      'channelTitle': channelTitle,
      'publishTime': publishTime,
      'linkURL': linkURL,
      'type': type,
    };
  }

  // Convert map to VideoCard instance
  static VideoCard fromMap(Map<String, dynamic> map) {
    return VideoCard(
      id: map['id'],
      thumbnailURL: map['thumbnailURL'],
      title: map['title'],
      channelTitle: map['channelTitle'],
      publishTime: map['publishTime'],
      linkURL: map['linkURL'],
      type: map['type'],
    );
  }

  // Helper method to get the formatted type (e.g., "View Playlist" or "View Video")
  String get typeForamatted => "View ${type[0].toUpperCase()}${type.substring(1)}";
}
