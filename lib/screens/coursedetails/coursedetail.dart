import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnhub/controllers/coursedetailscontroller/coursedetailscontrl.dart';

class CourseDetailsView extends StatelessWidget {
  CourseDetailsView({super.key});
  final courseDetCntrl = Get.put(CourseDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FB),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: Obx(
                () => ListView(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                  children: [
                    _buildCourseInfo(),
                    const SizedBox(height: 24),
                    _buildProgressCard(),
                    const SizedBox(height: 28),
                    _buildLessonHeader(),
                    const SizedBox(height: 12),
                    ...List.generate(
                      courseDetCntrl.lessons.length,
                      (index) => _buildLessonCard(index),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // HEADER
  // ------------------------------------------------------------

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 20, 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFEDEDF2))),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => Get.back(),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFF2F0FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 19,
                color: Color(0xFF6C4DF6),
              ),
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Text(
              'Course Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF171725),
              ),
            ),
          ),
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.bookmark_border_rounded,
              color: Color(0xFF555566),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // COURSE INFORMATION
  // ------------------------------------------------------------

  Widget _buildCourseInfo() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6C4DF6), Color(0xFF8B70FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C4DF6).withOpacity(0.20),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.code_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),

          const SizedBox(height: 20),

          Text(
            courseDetCntrl.course.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              const Icon(
                Icons.person_outline_rounded,
                size: 17,
                color: Colors.white70,
              ),
              const SizedBox(width: 6),
              Text(
                courseDetCntrl.course.instructor,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // PROGRESS
  // ------------------------------------------------------------

  Widget _buildProgressCard() {
    return Obx(() {
      final progress = courseDetCntrl.progress.value;

      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFEAEAEE)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Your Progress',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF171725),
                    ),
                  ),
                ),

                Text(
                  '${progress.round()}%',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF6C4DF6),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress / 100,
                minHeight: 10,
                backgroundColor: const Color(0xFFEDEBF7),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF6C4DF6),
                ),
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                const Icon(
                  Icons.check_circle_rounded,
                  size: 17,
                  color: Color(0xFF22A06B),
                ),

                const SizedBox(width: 6),

                Text(
                  '${courseDetCntrl.completedLessons} of '
                  '${courseDetCntrl.totalLessons} lessons completed',
                  style: const TextStyle(
                    color: Color(0xFF737381),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
  // ------------------------------------------------------------
  // LESSON HEADER
  // ------------------------------------------------------------

  Widget _buildLessonHeader() {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'Course Lessons',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Color(0xFF171725),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: const Color(0xFFEFEAFF),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '${courseDetCntrl.totalLessons} Lessons',
            style: const TextStyle(
              color: Color(0xFF6C4DF6),
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // LESSON CARD
  // ------------------------------------------------------------

  Widget _buildLessonCard(int index) {
    final lesson = courseDetCntrl.lessons[index];

    final bool completed = lesson.isCompleted;

    return GestureDetector(
      onTap: () {
        courseDetCntrl.toggleLesson(index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: completed ? const Color(0xFFF3FBF7) : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: completed
                ? const Color(0xFFCBEBDD)
                : const Color(0xFFEAEAEE),
          ),
        ),
        child: Row(
          children: [
            // Lesson number
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: completed
                    ? const Color(0xFFDDF5E9)
                    : const Color(0xFFF2F0FF),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: completed
                    ? const Icon(
                        Icons.check_rounded,
                        color: Color(0xFF22A06B),
                        size: 24,
                      )
                    : Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: Color(0xFF6C4DF6),
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
              ),
            ),

            const SizedBox(width: 14),

            // Lesson title
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lesson.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: completed
                          ? const Color(0xFF245B42)
                          : const Color(0xFF252532),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    completed ? 'Completed' : 'Pending',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: completed
                          ? const Color(0xFF22A06B)
                          : const Color(0xFF9696A3),
                    ),
                  ),
                ],
              ),
            ),

            // Status icon
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                completed
                    ? Icons.check_circle_rounded
                    : Icons.radio_button_unchecked_rounded,
                key: ValueKey(completed),
                color: completed
                    ? const Color(0xFF22A06B)
                    : const Color(0xFFB5B5BF),
                size: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
