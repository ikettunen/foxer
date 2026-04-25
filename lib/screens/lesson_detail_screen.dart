import 'package:flutter/material.dart';

class LessonDetailScreen extends StatefulWidget {
  final String title;
  final String duration;
  final String level;
  final int index;

  const LessonDetailScreen({
    super.key,
    required this.title,
    required this.duration,
    required this.level,
    required this.index,
  });

  @override
  State<LessonDetailScreen> createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen> {
  bool _isCompleted = false;

  final Map<int, Map<String, dynamic>> _lessonContent = {
    0: {
      'title': 'Introduction to Paragliding',
      'sections': [
        {
          'heading': 'What is Paragliding?',
          'content': 'Paragliding is an aerial sport in which pilots fly non-motorized aircrafts called paragliders. It requires no runway, just a hill or towing from a plane.'
        },
        {
          'heading': 'Basic Principles',
          'content': 'A paraglider is inflated by airflow and is controlled by the pilot via brake lines. The sport combines the thrill of flight with the freedom of choosing your own route.'
        },
        {
          'heading': 'Safety First',
          'content': 'Always wear proper safety equipment including a helmet, reserve parachute, and harness. Take lessons from certified instructors before flying independently.'
        },
      ]
    },
    1: {
      'title': 'Equipment Overview',
      'sections': [
        {
          'heading': 'The Paraglider',
          'content': 'Modern paragliders are made from ripstop nylon fabric. They consist of interconnected cells that form the canopy. Sizes typically range from 17 to 21 square meters.'
        },
        {
          'heading': 'Harness & Reserves',
          'content': 'A comfortable harness distributes your weight and houses the emergency reserve parachute. Quality equipment is essential for safety and comfort.'
        },
        {
          'heading': 'Accessory Gear',
          'content': 'Altimeter, variometer, GPS device, helmet, gloves, and appropriate clothing are important accessories for safe flying.'
        },
      ]
    },
    2: {
      'title': 'Pre-flight Checks',
      'sections': [
        {
          'heading': 'Weather Check',
          'content': 'Always check wind speed, direction, and cloud conditions. Avoid flying in strong winds, storms, or severely changing weather.'
        },
        {
          'heading': 'Equipment Inspection',
          'content': 'Check your paraglider for tears, inspect all lines for damage, ensure harness buckles are secure, and verify your helmet is in good condition.'
        },
        {
          'heading': 'Launch Site Assessment',
          'content': 'Survey the landing area, check for obstacles, identify emergency landing spots, and confirm wind direction indicators.'
        },
      ]
    },
  };

  @override
  Widget build(BuildContext context) {
    final content = _lessonContent[widget.index] ?? {
      'title': widget.title,
      'sections': [
        {
          'heading': 'Coming Soon',
          'content': 'Full lesson content will be available soon. Stay tuned!'
        }
      ]
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Lesson Header
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Level: ${widget.level}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Duration: ${widget.duration}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.paragliding,
                          size: 40,
                          color: Colors.grey[400],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Lesson Content
                  ...(content['sections'] as List<Map<String, String>>).map(
                    (section) => Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            section['heading']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            section['content']!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          // Floating Action Button for lesson completion
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: _isCompleted ? Colors.green : Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                setState(() {
                  _isCompleted = !_isCompleted;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      _isCompleted
                          ? 'Lesson marked as complete!'
                          : 'Lesson marked as incomplete.',
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              icon: Icon(_isCompleted ? Icons.check_circle : Icons.play_circle_outline),
              label: Text(_isCompleted ? 'Completed' : 'Mark as Complete'),
            ),
          ),
        ],
      ),
    );
  }
}
