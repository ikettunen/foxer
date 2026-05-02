import 'app_localizations.dart';

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get appTitle => 'Foxer Laskuvarjolentäminen';

  @override
  String get flightSites => 'Lentopaikat';

  @override
  String get lessons => 'Oppitunnit';

  @override
  String get readingMaterials => 'Lukumateriaalit';

  @override
  String get discussions => 'Keskustelut';

  @override
  String get login => 'Kirjaudu';

  @override
  String get logout => 'Kirjaudu ulos';

  @override
  String get email => 'Sähköposti';

  @override
  String get password => 'Salasana';

  @override
  String get email_hint => 'Syötä sähköpostiosoitteesi';

  @override
  String get password_hint => 'Syötä salasanasi';

  @override
  String get sign_in => 'Kirjaudu sisään';

  @override
  String get home => 'Koti';

  @override
  String get lesson_detail => 'Oppitunnin tiedot';

  @override
  String get mark_as_complete => 'Merkitse valmiiksi';

  @override
  String get completed => 'Valmis';

  @override
  String get level => 'Taso';

  @override
  String get duration => 'Kesto';

  @override
  String get beginner => 'Aloittaja';

  @override
  String get intermediate => 'Keskitaso';

  @override
  String get advanced => 'Edistynyt';

  @override
  String get lesson_marked_complete => 'Oppitunti merkitty valmiiksi!';

  @override
  String get lesson_marked_incomplete => 'Oppitunti merkitty keskeneräiseksi.';

  @override
  String get courses => 'Kurssit';

  @override
  String get selectCourse => 'Valitse kurssi';

  @override
  String get selectDay => 'Valitse päivä';

  @override
  String dayLabel(int day) {
    return 'Päivä $day';
  }

  @override
  String get locked => 'Lukittu';

  @override
  String get unlocked => 'Auki';

  @override
  String get preReading => 'Ennakkolukeminen';

  @override
  String get startQuiz => 'Aloita testi';

  @override
  String get keyPoints => 'Avainpisteet';

  @override
  String get quiz => 'Testi';

  @override
  String question(int current, int total) {
    return 'Kysymys $current/$total';
  }

  @override
  String get correct => 'Oikein!';

  @override
  String get incorrect => 'Väärin';

  @override
  String get explanation => 'Selitys';

  @override
  String get next => 'Seuraava';

  @override
  String get quizComplete => 'Testi valmis!';

  @override
  String yourScore(int score, int total) {
    return 'Pisteesi: $score/$total';
  }

  @override
  String get passed => 'Hyväksytty ✓';

  @override
  String get failed => 'Yritä uudelleen';

  @override
  String get backToCourses => 'Takaisin kursseille';

  @override
  String days(int count) {
    return '$count päivää';
  }

  @override
  String estimatedRead(int min) {
    return '$min min lukeminen';
  }
}
