import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ReadingMode { verseByVerse, continuousScroll }

class ReaderPreferences {
  final ReadingMode readingMode;
  final double arabicFontSize;
  final double translationFontSize;
  final bool showTajweedColoring;
  final bool showTranslation;
  final String selectedArabicFont;
  final ThemeMode themeMode;
  final int lastReadSurah;
  final int lastReadAyah;

  const ReaderPreferences({
    this.readingMode = ReadingMode.verseByVerse,
    this.arabicFontSize = 26.0,
    this.translationFontSize = 15.0,
    this.showTajweedColoring = true,
    this.showTranslation = true,
    this.selectedArabicFont = 'Amiri',
    this.themeMode = ThemeMode.system,
    this.lastReadSurah = 1,
    this.lastReadAyah = 1,
  });

  ReaderPreferences copyWith({
    ReadingMode? readingMode,
    double? arabicFontSize,
    double? translationFontSize,
    bool? showTajweedColoring,
    bool? showTranslation,
    String? selectedArabicFont,
    ThemeMode? themeMode,
    int? lastReadSurah,
    int? lastReadAyah,
  }) {
    return ReaderPreferences(
      readingMode: readingMode ?? this.readingMode,
      arabicFontSize: arabicFontSize ?? this.arabicFontSize,
      translationFontSize: translationFontSize ?? this.translationFontSize,
      showTajweedColoring: showTajweedColoring ?? this.showTajweedColoring,
      showTranslation: showTranslation ?? this.showTranslation,
      selectedArabicFont: selectedArabicFont ?? this.selectedArabicFont,
      themeMode: themeMode ?? this.themeMode,
      lastReadSurah: lastReadSurah ?? this.lastReadSurah,
      lastReadAyah: lastReadAyah ?? this.lastReadAyah,
    );
  }

  // Persistence keys
  static const String _keyReadingMode = 'pref_reading_mode';
  static const String _keyArabicFontSize = 'pref_arabic_font_size';
  static const String _keyTranslationFontSize = 'pref_translation_font_size';
  static const String _keyTajweedColoring = 'pref_tajweed_coloring';
  static const String _keyShowTranslation = 'pref_show_translation';
  static const String _keyArabicFont = 'pref_arabic_font';
  static const String _keyThemeMode = 'pref_theme_mode';
  static const String _keyLastReadSurah = 'pref_last_read_surah';
  static const String _keyLastReadAyah = 'pref_last_read_ayah';

  static Future<ReaderPreferences> load() async {
    final prefs = await SharedPreferences.getInstance();
    final modeIndex = prefs.getInt(_keyReadingMode) ?? 0;
    final themeIndex = prefs.getInt(_keyThemeMode) ?? 0;

    return ReaderPreferences(
      readingMode: ReadingMode.values[modeIndex.clamp(0, ReadingMode.values.length - 1)],
      arabicFontSize: prefs.getDouble(_keyArabicFontSize) ?? 26.0,
      translationFontSize: prefs.getDouble(_keyTranslationFontSize) ?? 15.0,
      showTajweedColoring: prefs.getBool(_keyTajweedColoring) ?? true,
      showTranslation: prefs.getBool(_keyShowTranslation) ?? true,
      selectedArabicFont: prefs.getString(_keyArabicFont) ?? 'Amiri',
      themeMode: ThemeMode.values[themeIndex.clamp(0, ThemeMode.values.length - 1)],
      lastReadSurah: prefs.getInt(_keyLastReadSurah) ?? 1,
      lastReadAyah: prefs.getInt(_keyLastReadAyah) ?? 1,
    );
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyReadingMode, readingMode.index);
    await prefs.setDouble(_keyArabicFontSize, arabicFontSize);
    await prefs.setDouble(_keyTranslationFontSize, translationFontSize);
    await prefs.setBool(_keyTajweedColoring, showTajweedColoring);
    await prefs.setBool(_keyShowTranslation, showTranslation);
    await prefs.setString(_keyArabicFont, selectedArabicFont);
    await prefs.setInt(_keyThemeMode, themeMode.index);
    await prefs.setInt(_keyLastReadSurah, lastReadSurah);
    await prefs.setInt(_keyLastReadAyah, lastReadAyah);
  }
}
