import 'package:flutter/material.dart';
import 'lesson_detail_screen.dart';

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
          children: const [
            Icon(Icons.paragliding, size: 32, color: Colors.white),
            SizedBox(width: 12),
            Text('Lessons'),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: lessons.length,
        itemBuilder: (context, index) {
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
      ),
    );
  }
}
