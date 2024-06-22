class Task {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String imageUrl;

  Task({
    required this.id,
    required this.title,
    this.description = '',
    required this.date,
    this.imageUrl = '',
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'].toString(),
      title: json['title'],
      description: json.containsKey('description') ? json['description'] : '',
      date: DateTime.now(),
      imageUrl: json.containsKey('imageUrl') ? json['imageUrl'] : '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'imageUrl': imageUrl,
    };
  }
}
