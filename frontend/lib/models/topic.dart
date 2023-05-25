class Topic{
  final int id;
  final String title;
  final String content;
  final String author; 
  final String forum; 
  final String date;

  Topic({required this.id, required this.title, required this.content, required this.author, required this.forum, required this.date});

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      author: json['author'],
      forum: json['forum'],
      date: json['date'],
    );
  }
}
