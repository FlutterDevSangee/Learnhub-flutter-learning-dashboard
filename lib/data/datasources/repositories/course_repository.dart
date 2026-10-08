import 'package:learnhub/Models/dashmodel.dart';
import 'package:learnhub/data/datasources/local/course_local_storage.dart';

class CourseRepository {
  final CourseLocalStorage localStorage;

  CourseRepository({required this.localStorage});

  Future<List<CourseModel>> getCourses() async {
    try {
      // ------------------------------------------------
      // MOCK API
      // ------------------------------------------------

      await Future.delayed(const Duration(seconds: 2));

      final response = [
        {
          'id': 1,
          'title': 'Python Programming',
          'instructor': 'John Smith',
          'progress': 65,
          'lessons': 20,
        },
        {
          'id': 2,
          'title': 'Generative AI',
          'instructor': 'Sarah Williams',
          'progress': 40,
          'lessons': 16,
        },
        {
          'id': 3,
          'title': 'Full Stack Development',
          'instructor': 'David Brown',
          'progress': 25,
          'lessons': 28,
        },
      ];

      // ------------------------------------------------
      // SAVE API DATA LOCALLY
      // ------------------------------------------------

      await localStorage.saveCourses(response);

      return response.map((json) => CourseModel.fromJson(json)).toList();
    } catch (e) {
      // ------------------------------------------------
      // API FAILED → GET LOCAL CACHE
      // ------------------------------------------------

      final cachedCourses = localStorage.getCourses();

      if (cachedCourses.isNotEmpty) {
        return cachedCourses.map((json) => CourseModel.fromJson(json)).toList();
      }

      rethrow;
    }
  }
}
