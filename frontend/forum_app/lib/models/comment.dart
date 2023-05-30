class Comment {
  final int id;
  final String content;
  final int author;
  final int topic;
  final DateTime date;

  Comment({required this.id, 
                      required this.content, 
                      required this.author, 
                      required this.topic, 
                      required this.date});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      content: json['content'],
      author: json['author'],
      topic: json['topic'],
      date: DateTime.parse(json['date']),
    );
  }
}
