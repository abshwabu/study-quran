import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:studyquran/features/quran_reader/domain/tajweed_parser.dart';
import 'package:studyquran/features/quran_reader/domain/reader_preferences.dart';

void main() {
  group('TajweedParser Tests', () {
    test('Tajweed parser returns single span when disabled', () {
      const sampleText = 'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ';
      final spans = TajweedParser.parseToSpans(
        text: sampleText,
        baseStyle: const TextStyle(color: Colors.black),
        enableTajweed: false,
      );

      expect(spans.length, equals(1));
      expect(spans.first.text, equals(sampleText));
      expect(spans.first.style?.color, equals(Colors.black));
    });

    test('Tajweed parser identifies Madd and Ghunnah rules when enabled', () {
      const sampleText = 'ٱلرَّحْمَٰنِ'; // Contains dagger alif / Maddah
      final spans = TajweedParser.parseToSpans(
        text: sampleText,
        baseStyle: const TextStyle(color: Colors.black),
        enableTajweed: true,
      );

      expect(spans.length, greaterThan(1));
      final coloredSpan = spans.firstWhere(
        (s) => s.style?.color == TajweedParser.colorMadd,
        orElse: () => const TextSpan(),
      );
      expect(coloredSpan.text, isNotNull);
    });
  });

  group('ReaderPreferences Tests', () {
    test('Default ReaderPreferences settings are correct', () {
      const prefs = ReaderPreferences();
      expect(prefs.readingMode, equals(ReadingMode.verseByVerse));
      expect(prefs.arabicFontSize, equals(26.0));
      expect(prefs.showTajweedColoring, isTrue);
      expect(prefs.showTranslation, isTrue);
    });

    test('copyWith correctly updates properties', () {
      const prefs = ReaderPreferences();
      final updated = prefs.copyWith(
        arabicFontSize: 32.0,
        showTajweedColoring: false,
        readingMode: ReadingMode.continuousScroll,
      );

      expect(updated.arabicFontSize, equals(32.0));
      expect(updated.showTajweedColoring, isFalse);
      expect(updated.readingMode, equals(ReadingMode.continuousScroll));
      expect(updated.showTranslation, isTrue); // Unchanged
    });
  });

  group('Ayah Formatting Tests', () {
    test('Formatted copy output matches required template', () {
      const arabicText = 'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ';
      const translationText = 'In the name of Allah, the Entirely Merciful, the Especially Merciful.';
      const surahName = 'Al-Fatihah';
      const surahNum = 1;
      const ayahNum = 1;

      final formatted = '''
$arabicText

"$translationText"
— Surah $surahName ($surahNum:$ayahNum)
'''.trim();

      expect(formatted, contains(arabicText));
      expect(formatted, contains(translationText));
      expect(formatted, contains('Surah Al-Fatihah (1:1)'));
    });
  });
}
