class VideoCard {
  final String? id;
  String? timestamp;
  final String? thumbnailURL;
  final String? title;
  final String? channelTitle;
  final String? publishTime;
  final String? linkURL;
  final String? type;
  final String? listStatus;
  String? completedVideos;
  String? totalVideos;
  bool? isSeen; // Updated to non-final to allow state change

  VideoCard({
    required this.id,
    this.timestamp,
    required this.thumbnailURL,
    required this.title,
    required this.channelTitle,
    required this.publishTime,
    required this.linkURL,
    required this.type,
    required this.listStatus,
    this.completedVideos,
    this.totalVideos,
    this.isSeen,
  });

  // Convert VideoCard instance to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'timestamp': timestamp,
      'thumbnailURL': thumbnailURL,
      'title': title,
      'channelTitle': channelTitle,
      'publishTime': publishTime,
      'linkURL': linkURL,
      'type': type,
      'listStatus': listStatus,
      'completedVideos': completedVideos,
      'totalVideos': totalVideos,
      'isSeen': isSeen,
    };
  }

  // Convert map to VideoCard instance
  static VideoCard fromMap(Map<String, dynamic> map) {
    return VideoCard(
      id: map['id'],
      timestamp: map['timestamp'],
      thumbnailURL: map['thumbnailURL'],
      title: map['title'],
      channelTitle: map['channelTitle'],
      publishTime: map['publishTime'],
      linkURL: map['linkURL'],
      type: map['type'],
      listStatus: map['listStatus'],
      completedVideos: map['completedVideos'],
      totalVideos: map['totalVideos'],
      isSeen: map['isSeen'],
    );
  }

  // Helper method to get the formatted type (e.g., "View Playlist" or "View Video")
  String get typeFormatted {
    if (type == null || type!.isEmpty) {
      return "Unknown";
    }
    return "View ${type![0].toUpperCase()}${type!.substring(1)}";
  }

  // Method to change the state of isSeen
  void changeIsSeenState() {
    isSeen = isSeen != null && isSeen! ? false : true;
  }
}
