class Forum {
  final int id;
  final String name;
  final DateTime date;

  Forum({required this.id, 
              required this.name, 
              required this.date});

  factory Forum.fromJson(Map<String, dynamic> json) {
    return Forum(
      id: json['id'],
      name: json['name'],
      date: DateTime.parse(json['date']),
    );
  }
}
