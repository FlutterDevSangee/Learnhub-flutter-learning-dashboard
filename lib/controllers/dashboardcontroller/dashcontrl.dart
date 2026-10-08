import 'package:get/get.dart';
import 'package:learnhub/Models/dashmodel.dart';

class CourseController extends GetxController {
  final courses = <CourseModel>[].obs;

  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCourses();
  }

  Future<void> fetchCourses() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Mock API
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

      courses.value = response
          .map((json) => CourseModel.fromJson(json))
          .toList();
    } catch (e) {
      errorMessage.value = 'Unable to load courses. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }
}
