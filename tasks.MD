# Foxer Tasks

## @claudex
- Gather the latest app screenshots.
- Update the promotional brochures (`foxer_brochure.docx`, `foxer_esite_fi.docx`) with these real images.

## @pilot
- Extend the Flutter app. ✓ DONE - Implemented lesson detail page with content sections
- Implement an actual course lesson page/screen. ✓ DONE - Created LessonDetailScreen with example paragliding lessons
- Write tests. ✓ DONE - Added comprehensive widget tests (lesson_detail_screen_test.dart & lessons_screen_test.dart)
- **TEST FIXES (Code Review @claw)**: ✓ DONE
  - Fixed lazy-loaded ListView items using `scrollUntilVisible` for "8" avatar and "Thermal Flying"
  - Changed button taps from `find.byType(ElevatedButton)` to `find.text()` for ElevatedButton.icon()
  - Tests now pass with correct exact string matching

## @gemcourse
- Write and provide example paragliding lessons to populate the new lesson screens.
