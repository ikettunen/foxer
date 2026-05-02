import 'package:flutter/material.dart';
import 'package:paragliding_training/generated_localizations/app_localizations.dart';
import 'lesson_detail_screen.dart';
import 'course_select_screen.dart';

class LessonsScreen extends StatelessWidget {
  const LessonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lessons = [
      {'title': 'Introduction to Paragliding', 'duration': '30 min', 'level': 'Beginner'},
      {'title': 'Equipment Overview', 'duration': '45 min', 'level': 'Beginner'},
      {'title': 'Pre-flight Checks', 'duration': '20 min', 'level': 'Beginner'},
      {'title': 'Launch Techniques', 'duration': '60 min', 'level': 'Intermediate'},
      {'title': 'Flight Control', 'duration': '90 min', 'level': 'Intermediate'},
      {'title': 'Landing Procedures', 'duration': '45 min', 'level': 'Intermediate'},
      {'title': 'Weather Analysis', 'duration': '60 min', 'level': 'Advanced'},
      {'title': 'Thermal Flying', 'duration': '120 min', 'level': 'Advanced'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.paragliding, size: 32, color: Colors.white),
            const SizedBox(width: 12),
            Text(AppLocalizations.of(context)!.lessons),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 1.5,
                  ),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => const CourseSelectScreen(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.school,
                          size: 36,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.selectCourse,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'PP1 — Varjoliitokurssi',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final lesson = lessons[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                    title: Text(lesson['title']!),
                    subtitle: Text('${lesson['duration']} • ${lesson['level']}'),
                    trailing: const Icon(Icons.play_circle_outline),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LessonDetailScreen(
                            title: lesson['title']!,
                            duration: lesson['duration']!,
                            level: lesson['level']!,
                            index: index,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              childCount: lessons.length,
            ),
          ),
        ],
      ),
    );
  }
}
