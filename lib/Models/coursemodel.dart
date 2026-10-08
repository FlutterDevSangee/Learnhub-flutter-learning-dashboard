class LessonModel {
  final int id;
  final String title;
  bool isCompleted;

  LessonModel({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });
}
