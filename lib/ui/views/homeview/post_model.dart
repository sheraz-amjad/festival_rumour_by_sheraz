class PostModel {
  final String username;
  final String timeAgo;
  final String content;
  final String imagePath;
  final int likes;
  final int comments;
  final String status; // 'live', 'past', 'upcoming'

  PostModel({
    required this.username,
    required this.timeAgo,
    required this.content,
    required this.imagePath,
    required this.likes,
    required this.comments,
    required this.status,
  });

  PostModel copyWith({
    String? username,
    String? timeAgo,
    String? content,
    String? imagePath,
    int? likes,
    int? comments,
    String? status,
  }) {
    return PostModel(
      username: username ?? this.username,
      timeAgo: timeAgo ?? this.timeAgo,
      content: content ?? this.content,
      imagePath: imagePath ?? this.imagePath,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PostModel &&
        other.username == username &&
        other.timeAgo == timeAgo &&
        other.content == content &&
        other.imagePath == imagePath &&
        other.likes == likes &&
        other.comments == comments &&
        other.status == status;
  }

  @override
  int get hashCode {
    return username.hashCode ^
    timeAgo.hashCode ^
    content.hashCode ^
    imagePath.hashCode ^
    likes.hashCode ^
    comments.hashCode ^
    status.hashCode;
  }

  @override
  String toString() {
    return 'PostModel(username: $username, timeAgo: $timeAgo, content: $content, imagePath: $imagePath, likes: $likes, comments: $comments, status: $status)';
  }
}
