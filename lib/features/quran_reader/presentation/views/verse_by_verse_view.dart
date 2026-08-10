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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListView.separated(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: ayahs.length + 1, // +1 for Bismillah header
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        if (index == 0) {
          // Surah Header & Bismillah (unless Surah 9 At-Tawbah)
          return Card(
            color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.5),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
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
                    '${surahMeta.nameTranslit} • ${surahMeta.nameTranslation}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  if (surahMeta.number != 9) ...[
                    const Divider(height: 24),
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
          );
        }

        final item = ayahs[index - 1];
        final baseArabicStyle = TextStyle(
          fontSize: prefs.arabicFontSize,
          fontFamily: prefs.selectedArabicFont,
          height: 2.0,
          color: isDark ? Colors.white : Colors.black87,
        );

        final List<TextSpan> arabicSpans = TajweedParser.parseToSpans(
          text: item.ayah.arabicTextUthmani,
          baseStyle: baseArabicStyle,
          enableTajweed: prefs.showTajweedColoring,
        );

        return Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${item.ayah.surahNumber}:${item.ayah.ayahNumber}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.more_vert),
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
                  const Divider(),
                  const SizedBox(height: 6),
                  Text(
                    item.translationText!,
                    style: TextStyle(
                      fontSize: prefs.translationFontSize,
                      height: 1.5,
                      color: isDark ? Colors.grey.shade300 : Colors.grey.shade800,
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
