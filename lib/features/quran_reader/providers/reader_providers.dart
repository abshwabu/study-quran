import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/reader_preferences.dart';

class ReaderPreferencesNotifier extends StateNotifier<ReaderPreferences> {
  ReaderPreferencesNotifier() : super(const ReaderPreferences()) {
    _init();
  }

  Future<void> _init() async {
    final loaded = await ReaderPreferences.load();
    state = loaded;
  }

  void updateReadingMode(ReadingMode mode) {
    state = state.copyWith(readingMode: mode);
    state.save();
  }

  void updateArabicFontSize(double size) {
    state = state.copyWith(arabicFontSize: size);
    state.save();
  }

  void updateTranslationFontSize(double size) {
    state = state.copyWith(translationFontSize: size);
    state.save();
  }

  void toggleTajweedColoring() {
    state = state.copyWith(showTajweedColoring: !state.showTajweedColoring);
    state.save();
  }

  void toggleTranslation() {
    state = state.copyWith(showTranslation: !state.showTranslation);
    state.save();
  }

  void updateArabicFont(String fontName) {
    state = state.copyWith(selectedArabicFont: fontName);
    state.save();
  }

  void updateThemeMode(ThemeMode themeMode) {
    state = state.copyWith(themeMode: themeMode);
    state.save();
  }

  void saveLastReadPosition(int surah, int ayah) {
    state = state.copyWith(lastReadSurah: surah, lastReadAyah: ayah);
    state.save();
  }
}

final readerPreferencesProvider =
    StateNotifierProvider<ReaderPreferencesNotifier, ReaderPreferences>((ref) {
  return ReaderPreferencesNotifier();
});
