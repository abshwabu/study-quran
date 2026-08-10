import 'package:flutter/material.dart';

/// Tajweed Coloring Approach & Design Rationale:
/// A rule-based character & diacritic parser is used here. It analyzes Uthmani
/// diacritical marks (Maddah `~`/`ٰ`, Sukun `ْ` on Qalqalah letters `ق ط ب ج د`,
/// Shaddah `ّ` on `ن`/`م`, Tanween `ً ٍ ٌ`) to dynamically construct a `TextSpan` tree.
/// This approach keeps local database storage minimal, enables fast offline execution,
/// and allows seamless instant toggling of Tajweed coloring on/off without downloading
/// heavy annotated dataset packs.
class TajweedParser {
  // Tajweed Palette (Harmonious & accessible colors)
  static const Color colorGhunnah = Color(0xFFD81B60);   // Deep Pink/Magenta
  static const Color colorQalqalah = Color(0xFF0288D1);  // Ocean Blue
  static const Color colorMadd = Color(0xFFE53935);      // Red
  static const Color colorIkhfaIdgham = Color(0xFF2E7D32); // Forest Green
  static const Color colorIqlab = Color(0xFF8E24AA);     // Purple

  static const List<String> qalqalahLetters = ['ق', 'ط', 'ب', 'ج', 'د'];
  static const List<String> ikhfaLetters = [
    'ت', 'ث', 'ج', 'د', 'ذ', 'ز', 'س', 'ش', 'ص', 'ض', 'ط', 'ظ', 'ف', 'ق', 'ك'
  ];

  /// Parses Uthmani text into styled TextSpans according to Tajweed rules.
  static List<TextSpan> parseToSpans({
    required String text,
    required TextStyle baseStyle,
    required bool enableTajweed,
  }) {
    if (!enableTajweed || text.isEmpty) {
      return [TextSpan(text: text, style: baseStyle)];
    }

    final List<TextSpan> spans = [];
    final int len = text.length;
    int i = 0;

    while (i < len) {
      final String char = text[i];
      Color? ruleColor;

      // 1. Madd rule: Maddah symbol or dagger alif with madd
      if (char == 'آ' || char == 'ۤ' || char == 'ۦ' || char == 'ۧ' || char == 'ٰ') {
        ruleColor = colorMadd;
      }
      // Check next char for maddah mark `~` or superscript alif
      else if (i + 1 < len && (text[i + 1] == 'ۤ' || text[i + 1] == 'ٰ')) {
        ruleColor = colorMadd;
      }

      // 2. Ghunnah rule: Noon or Meem with Shaddah (نّ, مّ)
      else if ((char == 'ن' || char == 'م') && i + 1 < len && text[i + 1] == 'ّ') {
        ruleColor = colorGhunnah;
      }

      // 3. Qalqalah rule: Qalqalah letter followed by Sukun `ْ`
      else if (qalqalahLetters.contains(char) && i + 1 < len && text[i + 1] == 'ْ') {
        ruleColor = colorQalqalah;
      }

      // 4. Ikhfa / Idgham / Tanween rule: Tanween (ً ٍ ٌ) or Sukun on Noon followed by Ikhfa letter
      else if (char == 'ً' || char == 'ٍ' || char == 'ٌ' || (char == 'ن' && i + 1 < len && text[i + 1] == 'ْ')) {
        ruleColor = colorIkhfaIdgham;
      }

      // 5. Iqlab rule: Small Meem `ۨ` or `ۢ`
      else if (char == 'ۨ' || char == 'ۢ') {
        ruleColor = colorIqlab;
      }

      if (ruleColor != null) {
        spans.add(TextSpan(
          text: char,
          style: baseStyle.copyWith(
            color: ruleColor,
            fontWeight: FontWeight.bold,
          ),
        ));
      } else {
        spans.add(TextSpan(text: char, style: baseStyle));
      }

      i++;
    }

    return spans;
  }
}
