class TodoModel {
  final String title;
  final bool isCompleted;
  TodoModel({required this.title, required this.isCompleted});

  TodoModel copyWith({String? title, bool? isCompleted}) {
    return TodoModel(
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  factory TodoModel.fromJson(Map<String, dynamic> data) {
    return TodoModel(title: data['title'], isCompleted: data['isCompleted']);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isCompleted': isCompleted,
    };
  }
}
