import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:studyquran/core/database/daos/quran_dao.dart';
import 'package:studyquran/core/database/app_database.dart';
import '../../domain/reader_preferences.dart';
import '../../domain/tajweed_parser.dart';
import '../widgets/ayah_actions_bottom_sheet.dart';

class ContinuousScrollView extends StatelessWidget {
  final List<AyahWithTranslation> ayahs;
  final Surah surahMeta;
  final ReaderPreferences prefs;
  final ScrollController scrollController;

  const ContinuousScrollView({
    super.key,
    required this.ayahs,
    required this.surahMeta,
    required this.prefs,
    required this.scrollController,
  });

  /// Converts an integer to Arabic-Indic numeral string (e.g. 1 -> ١)
  String _toArabicNumerals(int number) {
    const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    return number.toString().split('').map((digit) => arabicDigits[int.parse(digit)]).join('');
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseArabicStyle = TextStyle(
      fontSize: prefs.arabicFontSize,
      fontFamily: prefs.selectedArabicFont,
      height: 2.2,
      color: isDark ? Colors.white : Colors.black87,
    );

    final List<InlineSpan> continuousSpans = [];

    for (final item in ayahs) {
      // 1. Ayah Text with Tajweed Coloring
      final List<TextSpan> tajweedSpans = TajweedParser.parseToSpans(
        text: item.ayah.arabicTextUthmani,
        baseStyle: baseArabicStyle,
        enableTajweed: prefs.showTajweedColoring,
      );

      // Make text clickable to trigger Ayah Actions
      for (final span in tajweedSpans) {
        continuousSpans.add(
          TextSpan(
            text: span.text,
            style: span.style,
            recognizer: TapGestureRecognizer()
              ..onTap = () => AyahActionsBottomSheet.show(
                    context,
                    ayahData: item,
                    surahMeta: surahMeta,
                  ),
          ),
        );
      }

      // 2. Verse End Symbol ﴿١﴾
      final verseEndMarker = ' ﴿${_toArabicNumerals(item.ayah.ayahNumber)}﴾ ';
      continuousSpans.add(
        TextSpan(
          text: verseEndMarker,
          style: baseArabicStyle.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () => AyahActionsBottomSheet.show(
                  context,
                  ayahData: item,
                  surahMeta: surahMeta,
                ),
        ),
      );
    }

    return SingleChildScrollView(
      controller: scrollController,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Surah Frame Banner
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                Text(
                  'سُورَةُ ${surahMeta.nameArabic}',
                  style: TextStyle(
                    fontFamily: prefs.selectedArabicFont,
                    fontSize: prefs.arabicFontSize * 1.1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${surahMeta.nameTranslit} • ${surahMeta.ayahCount} Verses',
                  style: const TextStyle(fontSize: 13),
                ),
                if (surahMeta.number != 9) ...[
                  const Divider(height: 20),
                  Text(
                    'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
                    style: TextStyle(
                      fontFamily: prefs.selectedArabicFont,
                      fontSize: prefs.arabicFontSize * 0.9,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Flowing Paragraph Text Layout (Mushaf Style)
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.shade300),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: RichText(
                textAlign: TextAlign.justify,
                textDirection: TextDirection.rtl,
                text: TextSpan(children: continuousSpans),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
