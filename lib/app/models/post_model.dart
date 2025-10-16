import 'package:hive/hive.dart';
part 'post_model.g.dart';

@HiveType(typeId: 0)
class Post extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  int userId;
  @HiveField(2)
  String title;
  @HiveField(3)
  String body;
  @HiveField(4)
  bool isRead;
  @HiveField(5)
  int timerSeconds;
  @HiveField(6)
  int elapsedSeconds;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    this.isRead = false,
    required this.timerSeconds,
    this.elapsedSeconds = 0,
  });

  factory Post.fromJson(Map<String, dynamic> j) {
    return Post(
      id: j['id'],
      userId: j['userId'] ?? 0,
      title: j['title'] ?? '',
      body: j['body'] ?? '',
      timerSeconds: j['timerSeconds'] ?? _randomTimer(),
      elapsedSeconds: j['elapsedSeconds'] ?? 0,
      isRead: j['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'title': title,
        'body': body,
        'isRead': isRead,
        'timerSeconds': timerSeconds,
        'elapsedSeconds': elapsedSeconds,
      };
}

int _randomTimer() {
  final values = [10, 20, 25];
  values.shuffle();
  return values.first;
}
