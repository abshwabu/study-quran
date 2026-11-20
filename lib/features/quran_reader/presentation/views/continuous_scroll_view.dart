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
    final colorScheme = Theme.of(context).colorScheme;
    final baseArabicStyle = TextStyle(
      fontSize: prefs.arabicFontSize,
      fontFamily: prefs.selectedArabicFont,
      height: 2.25,
      color: colorScheme.onSurface,
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
            color: colorScheme.secondary,
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Surah Frame Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colorScheme.primaryContainer.withValues(alpha: 0.7),
                  colorScheme.secondaryContainer.withValues(alpha: 0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: colorScheme.outlineVariant),
            ),
            child: Column(
              children: [
                Text(
                  'سُورَةُ ${surahMeta.nameArabic}',
                  style: TextStyle(
                    fontFamily: prefs.selectedArabicFont,
                    fontSize: prefs.arabicFontSize * 1.15,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${surahMeta.nameTranslit} • ${surahMeta.ayahCount} Verses',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                if (surahMeta.number != 9) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Divider(color: colorScheme.primary.withValues(alpha: 0.2)),
                  ),
                  Text(
                    'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
                    style: TextStyle(
                      fontFamily: prefs.selectedArabicFont,
                      fontSize: prefs.arabicFontSize * 0.95,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Flowing Paragraph Text Layout (Mushaf Style)
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: colorScheme.outlineVariant),
            ),
            child: Padding(
              padding: const EdgeInsets.all(22),
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
