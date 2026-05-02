import 'package:flutter/material.dart';
import 'package:paragliding_training/generated_localizations/app_localizations.dart';
import '../models/course_model.dart';
import 'quiz_screen.dart';

class PreReadingScreen extends StatelessWidget {
  final CourseDay day;

  const PreReadingScreen({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final reading = day.preReading;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.preReading),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: Text(
                loc.estimatedRead(reading.estimatedReadMinutes),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white70,
                    ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    reading.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.calendar_today,
                          size: 14, color: colorScheme.primary),
                      const SizedBox(width: 4),
                      Text(
                        loc.dayLabel(day.day),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: colorScheme.primary,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Sections
                  ...reading.sections.map(
                    (section) => _SectionWidget(section: section),
                  ),

                  // Key Points
                  if (reading.keyPoints.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    _KeyPointsCard(keyPoints: reading.keyPoints),
                  ],

                  const SizedBox(height: 80), // space for bottom button
                ],
              ),
            ),
          ),
          // Start Quiz button
          if (day.quiz.questions.isNotEmpty)
            _StartQuizBar(day: day),
        ],
      ),
    );
  }
}

class _SectionWidget extends StatelessWidget {
  final ReadingSection section;

  const _SectionWidget({required this.section});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (section.safetyFlag)
            Container(
              margin: const EdgeInsets.only(bottom: 6),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.warning_amber_rounded,
                      size: 14, color: Colors.orange.shade800),
                  const SizedBox(width: 4),
                  Text(
                    'Safety',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.orange.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          Text(
            section.heading,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
          ),
          const SizedBox(height: 8),
          _MarkdownText(text: section.body),
          const Divider(height: 24),
        ],
      ),
    );
  }
}

/// Simple inline-bold markdown renderer (handles **bold** patterns).
class _MarkdownText extends StatelessWidget {
  final String text;

  const _MarkdownText({required this.text});

  List<InlineSpan> _buildSpans(BuildContext context) {
    final base = DefaultTextStyle.of(context).style;
    final spans = <InlineSpan>[];
    final pattern = RegExp(r'\*\*(.+?)\*\*');
    int last = 0;
    for (final match in pattern.allMatches(text)) {
      if (match.start > last) {
        spans.add(TextSpan(
          text: text.substring(last, match.start),
          style: base,
        ));
      }
      spans.add(TextSpan(
        text: match.group(1),
        style: base.copyWith(fontWeight: FontWeight.bold),
      ));
      last = match.end;
    }
    if (last < text.length) {
      spans.add(TextSpan(text: text.substring(last), style: base));
    }
    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: _buildSpans(context)),
    );
  }
}

class _KeyPointsCard extends StatelessWidget {
  final List<String> keyPoints;

  const _KeyPointsCard({required this.keyPoints});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withOpacity(0.4),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colorScheme.primary.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline,
                  color: colorScheme.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                loc.keyPoints,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...keyPoints.map(
            (kp) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle_outline,
                      size: 16, color: colorScheme.primary),
                  const SizedBox(width: 8),
                  Expanded(child: Text(kp)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StartQuizBar extends StatelessWidget {
  final CourseDay day;

  const _StartQuizBar({required this.day});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: FilledButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => QuizScreen(quiz: day.quiz),
              ),
            );
          },
          icon: const Icon(Icons.quiz),
          label: Text(loc.startQuiz),
        ),
      ),
    );
  }
}
