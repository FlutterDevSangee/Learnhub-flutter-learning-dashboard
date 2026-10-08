import 'package:get_storage/get_storage.dart';

class CourseLocalStorage {
  final GetStorage _storage = GetStorage();

  static const String coursesKey = 'cached_courses';

  Future<void> saveCourses(List<Map<String, dynamic>> courses) async {
    await _storage.write(coursesKey, courses);
  }

  List<Map<String, dynamic>> getCourses() {
    final data = _storage.read(coursesKey);

    if (data == null) {
      return [];
    }

    return List<Map<String, dynamic>>.from(
      (data as List).map((item) => Map<String, dynamic>.from(item)),
    );
  }

  bool hasCachedCourses() {
    return _storage.hasData(coursesKey);
  }

  Future<void> clearCourses() async {
    await _storage.remove(coursesKey);
  }
}
