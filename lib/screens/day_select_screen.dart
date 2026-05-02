import 'package:flutter/material.dart';
import 'package:paragliding_training/generated_localizations/app_localizations.dart';
import '../models/course_model.dart';
import 'pre_reading_screen.dart';

class DaySelectScreen extends StatelessWidget {
  final CourseData courseData;

  const DaySelectScreen({super.key, required this.courseData});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final days = courseData.days;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.selectDay),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: days.length,
        itemBuilder: (context, index) {
          final day = days[index];
          final isUnlocked = index == 0; // Day 1 unlocked, rest locked
          return _DayCard(
            day: day,
            isUnlocked: isUnlocked,
            onTap: isUnlocked
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => PreReadingScreen(
                          day: day,
                        ),
                      ),
                    );
                  }
                : null,
          );
        },
      ),
    );
  }
}

class _DayCard extends StatelessWidget {
  final CourseDay day;
  final bool isUnlocked;
  final VoidCallback? onTap;

  const _DayCard({
    required this.day,
    required this.isUnlocked,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: isUnlocked ? 3 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: isUnlocked
            ? BorderSide(color: colorScheme.primary, width: 1.5)
            : BorderSide.none,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Day number badge
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: isUnlocked
                      ? colorScheme.primaryContainer
                      : colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    '${day.day}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: isUnlocked
                              ? colorScheme.onPrimaryContainer
                              : colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Title and description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loc.dayLabel(day.day),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: isUnlocked
                                ? colorScheme.primary
                                : colorScheme.onSurfaceVariant,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      day.title,
                      style:
                          Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: isUnlocked
                                    ? colorScheme.onSurface
                                    : colorScheme.onSurfaceVariant,
                              ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      day.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Lock/arrow icon
              Icon(
                isUnlocked ? Icons.arrow_forward_ios : Icons.lock_outline,
                size: 18,
                color: isUnlocked
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
