// Models for PP1 course JSON data

class CourseOption {
  final String id;
  final String title;
  final String titleEn;
  final String description;
  final int days;
  final int hoursPerDay;

  const CourseOption({
    required this.id,
    required this.title,
    required this.titleEn,
    required this.description,
    required this.days,
    required this.hoursPerDay,
  });

  factory CourseOption.fromJson(Map<String, dynamic> json) {
    return CourseOption(
      id: json['id'] as String,
      title: json['title'] as String,
      titleEn: json['titleEn'] as String,
      description: json['description'] as String,
      days: json['days'] as int,
      hoursPerDay: json['hoursPerDay'] as int,
    );
  }
}

class QuizOption {
  final String id;
  final String text;

  const QuizOption({required this.id, required this.text});

  factory QuizOption.fromJson(Map<String, dynamic> json) {
    return QuizOption(id: json['id'] as String, text: json['text'] as String);
  }
}

class QuizQuestion {
  final String id;
  final String question;
  final List<QuizOption> options;
  final String correctAnswer;
  final String explanation;

  const QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      id: json['id'] as String,
      question: json['question'] as String,
      options: (json['options'] as List)
          .map((o) => QuizOption.fromJson(o as Map<String, dynamic>))
          .toList(),
      correctAnswer: json['correctAnswer'] as String,
      explanation: json['explanation'] as String,
    );
  }
}

class CourseQuiz {
  final String id;
  final int passMark;
  final List<QuizQuestion> questions;

  const CourseQuiz({
    required this.id,
    required this.passMark,
    required this.questions,
  });

  factory CourseQuiz.fromJson(Map<String, dynamic> json) {
    return CourseQuiz(
      id: json['id'] as String,
      passMark: json['passMark'] as int,
      questions: (json['questions'] as List)
          .map((q) => QuizQuestion.fromJson(q as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ReadingSection {
  final String heading;
  final String body;
  final bool safetyFlag;

  const ReadingSection({
    required this.heading,
    required this.body,
    required this.safetyFlag,
  });

  factory ReadingSection.fromJson(Map<String, dynamic> json) {
    return ReadingSection(
      heading: json['heading'] as String,
      body: json['body'] as String,
      safetyFlag: (json['safetyFlag'] as bool?) ?? false,
    );
  }
}

class PreReading {
  final String id;
  final String title;
  final int estimatedReadMinutes;
  final List<ReadingSection> sections;
  final List<String> keyPoints;

  const PreReading({
    required this.id,
    required this.title,
    required this.estimatedReadMinutes,
    required this.sections,
    required this.keyPoints,
  });

  factory PreReading.fromJson(Map<String, dynamic> json) {
    return PreReading(
      id: json['id'] as String,
      title: json['title'] as String,
      estimatedReadMinutes: (json['estimatedReadMinutes'] as int?) ?? 0,
      sections: (json['sections'] as List)
          .map((s) => ReadingSection.fromJson(s as Map<String, dynamic>))
          .toList(),
      keyPoints: (json['keyPoints'] as List?)
              ?.map((k) => k as String)
              .toList() ??
          [],
    );
  }
}

class CourseDay {
  final int day;
  final String title;
  final String titleEn;
  final String description;
  final PreReading preReading;
  final CourseQuiz quiz;

  const CourseDay({
    required this.day,
    required this.title,
    required this.titleEn,
    required this.description,
    required this.preReading,
    required this.quiz,
  });

  factory CourseDay.fromJson(Map<String, dynamic> json) {
    return CourseDay(
      day: json['day'] as int,
      title: json['title'] as String,
      titleEn: json['titleEn'] as String,
      description: json['description'] as String,
      preReading: PreReading.fromJson(
          json['preReading'] as Map<String, dynamic>),
      quiz: CourseQuiz.fromJson(json['quiz'] as Map<String, dynamic>),
    );
  }
}

class CourseData {
  final CourseOption course;
  final List<CourseDay> days;

  const CourseData({required this.course, required this.days});

  factory CourseData.fromJson(Map<String, dynamic> json) {
    return CourseData(
      course: CourseOption.fromJson(json['course'] as Map<String, dynamic>),
      days: (json['days'] as List)
          .map((d) => CourseDay.fromJson(d as Map<String, dynamic>))
          .toList(),
    );
  }
}
