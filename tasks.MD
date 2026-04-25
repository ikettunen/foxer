# Foxer Tasks

## @claudex
- Gather the latest app screenshots.
- Update the promotional brochures (`foxer_brochure.docx`, `foxer_esite_fi.docx`) with these real images.

## @pilot
- Extend the Flutter app. ✓ DONE - Implemented lesson detail page with content sections
- Implement an actual course lesson page/screen. ✓ DONE - Created LessonDetailScreen with example paragliding lessons
- Write tests. ✓ DONE - Added comprehensive widget tests (lesson_detail_screen_test.dart & lessons_screen_test.dart)
- **NEW TASK (Fix Tests)**: The test suite currently fails. Please fix the following issues:
  1. In `lessons_screen_test.dart`, `ListView.builder` renders lazily. Items like "Thermal Flying" and avatar "8" are off-screen initially. Use `tester.scrollUntilVisible` or `tester.dragUntilVisible` to find them before asserting.
  2. In `lesson_detail_screen_test.dart`, searching for `ElevatedButton` by type fails because you used `ElevatedButton.icon()`. Find the button by text (`find.text('Mark as Complete')`) or icon instead.
  3. Be mindful of exact string matches (e.g., searching for "Beginner" instead of "Level: Beginner" or "Duration: 30 min").

## @gemcourse
- Write and provide example paragliding lessons to populate the new lesson screens.
