import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Foxer Paragliding';

  @override
  String get flightSites => 'Flight Sites';

  @override
  String get lessons => 'Lessons';

  @override
  String get readingMaterials => 'Reading Materials';

  @override
  String get discussions => 'Discussions';

  @override
  String get login => 'Login';

  @override
  String get logout => 'Logout';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get email_hint => 'Enter your email';

  @override
  String get password_hint => 'Enter your password';

  @override
  String get sign_in => 'Sign In';

  @override
  String get home => 'Home';

  @override
  String get lesson_detail => 'Lesson Details';

  @override
  String get mark_as_complete => 'Mark as Complete';

  @override
  String get completed => 'Completed';

  @override
  String get level => 'Level';

  @override
  String get duration => 'Duration';

  @override
  String get beginner => 'Beginner';

  @override
  String get intermediate => 'Intermediate';

  @override
  String get advanced => 'Advanced';

  @override
  String get lesson_marked_complete => 'Lesson marked as complete!';

  @override
  String get lesson_marked_incomplete => 'Lesson marked as incomplete.';

  @override
  String get courses => 'Courses';

  @override
  String get selectCourse => 'Select Course';

  @override
  String get selectDay => 'Select Day';

  @override
  String dayLabel(int day) {
    return 'Day $day';
  }

  @override
  String get locked => 'Locked';

  @override
  String get unlocked => 'Unlocked';

  @override
  String get preReading => 'Pre-Reading';

  @override
  String get startQuiz => 'Start Quiz';

  @override
  String get keyPoints => 'Key Points';

  @override
  String get quiz => 'Quiz';

  @override
  String question(int current, int total) {
    return 'Question $current of $total';
  }

  @override
  String get correct => 'Correct!';

  @override
  String get incorrect => 'Incorrect';

  @override
  String get explanation => 'Explanation';

  @override
  String get next => 'Next';

  @override
  String get quizComplete => 'Quiz Complete!';

  @override
  String yourScore(int score, int total) {
    return 'Your score: $score/$total';
  }

  @override
  String get passed => 'Passed ✓';

  @override
  String get failed => 'Try again';

  @override
  String get backToCourses => 'Back to Courses';

  @override
  String days(int count) {
    return '$count days';
  }

  @override
  String estimatedRead(int min) {
    return '$min min read';
  }
}
