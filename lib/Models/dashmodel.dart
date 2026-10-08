class CourseModel {
  final int id;
  final String title;
  final String instructor;
  final int progress;
  final int lessons;

  CourseModel({
    required this.id,
    required this.title,
    required this.instructor,
    required this.progress,
    required this.lessons,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      title: json['title'],
      instructor: json['instructor'],
      progress: json['progress'],
      lessons: json['lessons'],
    );
  }
}
