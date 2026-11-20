import 'package:flutter/material.dart';
import 'package:studyquran/core/database/daos/quran_dao.dart';
import 'package:studyquran/core/database/app_database.dart';
import '../../domain/reader_preferences.dart';
import '../../domain/tajweed_parser.dart';
import '../widgets/ayah_actions_bottom_sheet.dart';

class VerseByVerseView extends StatelessWidget {
  final List<AyahWithTranslation> ayahs;
  final Surah surahMeta;
  final ReaderPreferences prefs;
  final ScrollController scrollController;
  final Function(int ayahNumber) onAyahVisible;

  const VerseByVerseView({
    super.key,
    required this.ayahs,
    required this.surahMeta,
    required this.prefs,
    required this.scrollController,
    required this.onAyahVisible,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListView.separated(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: ayahs.length + 1, // +1 for Bismillah header
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        if (index == 0) {
          // Surah Header & Bismillah (unless Surah 9 At-Tawbah)
          return Container(
            margin: const EdgeInsets.only(bottom: 6),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
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
                  '${surahMeta.nameTranslit} • ${surahMeta.nameTranslation} • ${surahMeta.ayahCount} Verses',
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
          );
        }

        final item = ayahs[index - 1];
        final baseArabicStyle = TextStyle(
          fontSize: prefs.arabicFontSize,
          fontFamily: prefs.selectedArabicFont,
          height: 2.1,
          color: colorScheme.onSurface,
        );

        final List<TextSpan> arabicSpans = TajweedParser.parseToSpans(
          text: item.ayah.arabicTextUthmani,
          baseStyle: baseArabicStyle,
          enableTajweed: prefs.showTajweedColoring,
        );

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Ayah Header & Action Toolbar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: colorScheme.primary.withValues(alpha: 0.3)),
                      ),
                      child: Text(
                        '${item.ayah.surahNumber}:${item.ayah.ayahNumber}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.more_horiz),
                          tooltip: 'Ayah Options & Tools',
                          onPressed: () => AyahActionsBottomSheet.show(
                            context,
                            ayahData: item,
                            surahMeta: surahMeta,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Arabic Text Rendering with Tajweed
                RichText(
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  text: TextSpan(children: arabicSpans),
                ),

                // Translation Display
                if (prefs.showTranslation && item.translationText != null) ...[
                  const SizedBox(height: 12),
                  Divider(color: colorScheme.outlineVariant),
                  const SizedBox(height: 8),
                  Text(
                    item.translationText!,
                    style: TextStyle(
                      fontSize: prefs.translationFontSize,
                      height: 1.55,
                      color: colorScheme.onSurface.withValues(alpha: 0.88),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
