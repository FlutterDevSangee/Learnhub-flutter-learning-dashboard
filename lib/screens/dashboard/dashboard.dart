import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnhub/Models/dashmodel.dart';
import 'package:learnhub/controllers/dashboardcontroller/dashcontrl.dart';
import 'package:learnhub/screens/coursedetails/coursedetail.dart';

class DashboardView extends StatelessWidget {
  DashboardView({super.key});
  final dashBoardCntrl = Get.put(CourseController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SafeArea(
        child: Obx(() {
          // ─────────────────────────────
          // Loading
          // ─────────────────────────────
          if (dashBoardCntrl.isLoading.value) {
            return const _LoadingView();
          }

          // ─────────────────────────────
          // Error
          // ─────────────────────────────
          if (dashBoardCntrl.errorMessage.isNotEmpty) {
            return _ErrorView(
              message: dashBoardCntrl.errorMessage.value,
              onRetry: dashBoardCntrl.fetchCourses,
            );
          }

          // ─────────────────────────────
          // Empty
          // ─────────────────────────────
          if (dashBoardCntrl.courses.isEmpty) {
            return const _EmptyView();
          }

          // ─────────────────────────────
          // Success
          // ─────────────────────────────
          return _SuccessView(courses: dashBoardCntrl.courses);
        }),
      ),
    );
  }
}

// ═════════════════════════════════════════════
// SUCCESS VIEW
// ═════════════════════════════════════════════

class _SuccessView extends StatelessWidget {
  final List<CourseModel> courses;

  const _SuccessView({required this.courses});

  @override
  Widget build(BuildContext context) {
    final completed = courses.where((course) => course.progress == 100).length;

    final averageProgress = courses.isEmpty
        ? 0
        : courses.map((e) => e.progress).reduce((a, b) => a + b) ~/
              courses.length;

    return RefreshIndicator(
      onRefresh: () async {
        await Get.find<CourseController>().fetchCourses();
      },
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          // ─────────────────────────────
          // Header
          // ─────────────────────────────
          SliverToBoxAdapter(child: _Header(averageProgress: averageProgress)),

          // ─────────────────────────────
          // Summary
          // ─────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 25),
              child: Row(
                children: [
                  Expanded(
                    child: _SummaryCard(
                      icon: Icons.menu_book_rounded,
                      value: '${courses.length}',
                      label: 'Courses',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _SummaryCard(
                      icon: Icons.check_circle_outline_rounded,
                      value: '$completed',
                      label: 'Completed',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _SummaryCard(
                      icon: Icons.trending_up_rounded,
                      value: '$averageProgress%',
                      label: 'Progress',
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ─────────────────────────────
          // Section Title
          // ─────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'My Courses',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF181A20),
                    ),
                  ),
                  Text(
                    '${courses.length} courses',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF858995),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ─────────────────────────────
          // Course List
          // ─────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final course = courses[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _CourseCard(course: course),
                );
              }, childCount: courses.length),
            ),
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════
// HEADER
// ═════════════════════════════════════════════

class _Header extends StatelessWidget {
  final int averageProgress;

  const _Header({required this.averageProgress});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 25, 20, 28),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6C63FF), Color(0xFF5146E5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.school_rounded,
                  color: Colors.white,
                  size: 27,
                ),
              ),

              const SizedBox(width: 13),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good morning 👋',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Sangeerth',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.notifications_none_rounded,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          // Progress banner
          Container(
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white.withOpacity(0.12)),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 58,
                  height: 58,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: averageProgress / 100,
                        strokeWidth: 5,
                        backgroundColor: Colors.white.withOpacity(0.2),
                        valueColor: const AlwaysStoppedAnimation(Colors.white),
                      ),
                      Text(
                        '$averageProgress%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 16),

                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Keep learning!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'You are making great progress.',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════
// SUMMARY CARD
// ═════════════════════════════════════════════

class _SummaryCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _SummaryCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF6C63FF), size: 22),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF20222A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(fontSize: 10.5, color: Color(0xFF8A8E99)),
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════
// COURSE CARD
// ═════════════════════════════════════════════

class _CourseCard extends StatelessWidget {
  final CourseModel course;

  const _CourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    final progress = course.progress / 100;

    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () {
        Get.toNamed('/course-details', arguments: course);
      },
      child: Container(
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.045),
              blurRadius: 18,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Course icon
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFEAE8FF), Color(0xFFF3F1FF)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    _getCourseIcon(course.title),
                    color: const Color(0xFF6C63FF),
                    size: 27,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF20222A),
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.person_outline_rounded,
                            size: 15,
                            color: Color(0xFF9296A2),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              course.instructor,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF858995),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Progress
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Course progress',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF777B87),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${course.progress}%',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6C63FF),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 7,
                backgroundColor: const Color(0xFFEDEEF3),
                valueColor: const AlwaysStoppedAnimation(Color(0xFF6C63FF)),
              ),
            ),

            const SizedBox(height: 17),

            Row(
              children: [
                const Icon(
                  Icons.play_circle_outline_rounded,
                  size: 18,
                  color: Color(0xFF858995),
                ),
                const SizedBox(width: 5),
                Text(
                  '${course.lessons} Lessons',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF858995),
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const Spacer(),

                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => CourseDetailsView(), arguments: course);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 17),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.arrow_forward_rounded, size: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCourseIcon(String title) {
    if (title.toLowerCase().contains('python')) {
      return Icons.code_rounded;
    }

    if (title.toLowerCase().contains('ai')) {
      return Icons.auto_awesome_rounded;
    }

    if (title.toLowerCase().contains('full stack')) {
      return Icons.web_rounded;
    }

    return Icons.menu_book_rounded;
  }
}

// ═════════════════════════════════════════════
// LOADING
// ═════════════════════════════════════════════

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 245,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6C63FF), Color(0xFF5146E5)],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35),
            ),
          ),
        ),
        const SizedBox(height: 30),
        const CircularProgressIndicator(color: Color(0xFF6C63FF)),
        const SizedBox(height: 15),
        const Text(
          'Loading your courses...',
          style: TextStyle(color: Color(0xFF777B87), fontSize: 14),
        ),
      ],
    );
  }
}

// ═════════════════════════════════════════════
// EMPTY
// ═════════════════════════════════════════════

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFFEDEBFF),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(
                Icons.menu_book_outlined,
                size: 48,
                color: Color(0xFF6C63FF),
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'No courses yet',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w800,
                color: Color(0xFF20222A),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your courses will appear here once they are available.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF858995),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                Get.find<CourseController>().fetchCourses();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C63FF),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════
// ERROR
// ═════════════════════════════════════════════

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFFFFEEEE),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(
                Icons.cloud_off_rounded,
                size: 48,
                color: Color(0xFFE45757),
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'Oops! Something went wrong',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color(0xFF20222A),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF858995),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C63FF),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
