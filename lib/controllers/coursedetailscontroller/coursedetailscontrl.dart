import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learnhub/Models/coursemodel.dart';

class CourseDetailController extends GetxController {
  late final dynamic course;

  final lessons = <LessonModel>[].obs;

  final progress = 0.0.obs;

  // GetStorage instance
  final GetStorage storage = GetStorage();

  // Storage key
  String get _storageKey => 'course_${course.id}_details';

  @override
  void onInit() {
    super.onInit();

    course = Get.arguments;

    _loadLessons();
  }

  // ============================================================
  // LOAD LESSONS
  // ============================================================

  void _loadLessons() {
    final cachedData = storage.read(_storageKey);

    if (cachedData != null) {
      // --------------------------------------------------------
      // LOAD FROM LOCAL STORAGE
      // --------------------------------------------------------

      final List<dynamic> savedLessons = cachedData['lessons'];

      lessons.value = savedLessons.map((lesson) {
        return LessonModel(
          id: lesson['id'],
          title: lesson['title'],
          isCompleted: lesson['isCompleted'] ?? false,
        );
      }).toList();

      // Load saved progress
      progress.value = (cachedData['progress'] ?? 0).toDouble();

      return;
    }

    // ----------------------------------------------------------
    // FIRST TIME OPENING COURSE
    // ----------------------------------------------------------

    lessons.value = [
      LessonModel(id: 1, title: 'Introduction', isCompleted: true),
      LessonModel(id: 2, title: 'Variables & Data Types', isCompleted: true),
      LessonModel(id: 3, title: 'Functions'),
      LessonModel(id: 4, title: 'Object Oriented Programming'),
      LessonModel(id: 5, title: 'Exception Handling'),
      LessonModel(id: 6, title: 'Final Project'),
    ];

    _calculateProgress();

    // Save initial data
    _saveLessons();
  }

  // ============================================================
  // TOGGLE LESSON
  // ============================================================

  Future<void> toggleLesson(int index) async {
    lessons[index].isCompleted = !lessons[index].isCompleted;

    lessons.refresh();

    _calculateProgress();

    // Save changes locally
    await _saveLessons();
  }

  // ============================================================
  // CALCULATE PROGRESS
  // ============================================================

  void _calculateProgress() {
    if (lessons.isEmpty) {
      progress.value = 0;
      return;
    }

    final completed = lessons.where((lesson) => lesson.isCompleted).length;

    progress.value = (completed / lessons.length) * 100;
  }

  // ============================================================
  // SAVE LESSONS
  // ============================================================

  Future<void> _saveLessons() async {
    final data = {
      'progress': progress.value,
      'lessons': lessons.map((lesson) {
        return {
          'id': lesson.id,
          'title': lesson.title,
          'isCompleted': lesson.isCompleted,
        };
      }).toList(),
    };

    await storage.write(_storageKey, data);
  }

  // ============================================================
  // GETTERS
  // ============================================================

  int get completedLessons =>
      lessons.where((lesson) => lesson.isCompleted).length;

  int get totalLessons => lessons.length;
}
