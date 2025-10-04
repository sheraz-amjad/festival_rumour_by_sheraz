class PostModel {
  final String username;
  final String timeAgo;
  final String content;
  final String imagePath;
  final int likes;
  final int comments;

  PostModel({
    required this.username,
    required this.timeAgo,
    required this.content,
    required this.imagePath,
    required this.likes,
    required this.comments,
  });

  PostModel copyWith({
    String? username,
    String? timeAgo,
    String? content,
    String? imagePath,
    int? likes,
    int? comments,
  }) {
    return PostModel(
      username: username ?? this.username,
      timeAgo: timeAgo ?? this.timeAgo,
      content: content ?? this.content,
      imagePath: imagePath ?? this.imagePath,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
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
        other.comments == comments;
  }

  @override
  int get hashCode {
    return username.hashCode ^
    timeAgo.hashCode ^
    content.hashCode ^
    imagePath.hashCode ^
    likes.hashCode ^
    comments.hashCode;
  }

  @override
  String toString() {
    return 'PostModel(username: $username, timeAgo: $timeAgo, content: $content, imagePath: $imagePath, likes: $likes, comments: $comments)';
  }
}
