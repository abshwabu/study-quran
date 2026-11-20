import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/daos/quran_dao.dart';
import '../../domain/reader_preferences.dart';
import '../../../morphology/providers/morphology_providers.dart';
import '../../../morphology/presentation/widgets/word_morphology_bottom_sheet.dart';

class WordByWordView extends ConsumerWidget {
  final List<AyahWithTranslation> ayahs;
  final ReaderPreferences preferences;
  final Function(AyahWithTranslation ayah) onAyahSelected;

  const WordByWordView({
    super.key,
    required this.ayahs,
    required this.preferences,
    required this.onAyahSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: ayahs.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final ayahData = ayahs[index];
        final wordsAsync = ref.watch(wordsForAyahProvider((
          surahNumber: ayahData.ayah.surahNumber,
          ayahNumber: ayahData.ayah.ayahNumber,
        )));

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Ayah Number Header
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
                        'Ayah ${ayahData.ayah.surahNumber}:${ayahData.ayah.ayahNumber}',
                        style: TextStyle(
                          fontSize: 12,
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_horiz),
                      tooltip: 'Ayah Options & Tools',
                      onPressed: () => onAyahSelected(ayahData),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Word-by-Word Wrapped Flow
                wordsAsync.when(
                  loading: () => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  error: (_, __) => _FallbackAyahText(arabicText: ayahData.ayah.arabicTextUthmani),
                  data: (wordsList) {
                    if (wordsList.isEmpty) {
                      return _FallbackAyahText(arabicText: ayahData.ayah.arabicTextUthmani);
                    }

                    return Directionality(
                      textDirection: TextDirection.rtl,
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 10,
                        alignment: WrapAlignment.start,
                        children: wordsList.map((wordData) {
                          final word = wordData.word;

                          return InkWell(
                            onTap: () => WordMorphologyBottomSheet.show(context, wordData),
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              decoration: BoxDecoration(
                                color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: colorScheme.outlineVariant,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Arabic Text
                                  Text(
                                    word.arabicText,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Uthmani',
                                      fontSize: preferences.arabicFontSize,
                                      fontWeight: FontWeight.bold,
                                      color: colorScheme.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),

                                  // Transliteration
                                  Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: Text(
                                      word.transliteration,
                                      style: TextStyle(
                                        fontSize: preferences.translationFontSize - 3,
                                        fontWeight: FontWeight.w600,
                                        color: colorScheme.secondary,
                                      ),
                                    ),
                                  ),

                                  // Literal Gloss
                                  if (word.translationGloss.isNotEmpty) ...[
                                    const SizedBox(height: 2),
                                    Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: Text(
                                        word.translationGloss,
                                        style: TextStyle(
                                          fontSize: preferences.translationFontSize - 4,
                                          color: colorScheme.onSurfaceVariant,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),

                // Complete Verse Translation
                if (preferences.showTranslation && ayahData.translationText != null) ...[
                  const SizedBox(height: 14),
                  Divider(color: colorScheme.outlineVariant),
                  const SizedBox(height: 6),
                  Text(
                    ayahData.translationText!,
                    style: TextStyle(
                      fontSize: preferences.translationFontSize,
                      height: 1.5,
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

class _FallbackAyahText extends StatelessWidget {
  final String arabicText;

  const _FallbackAyahText({required this.arabicText});

  @override
  Widget build(BuildContext context) {
    return Text(
      arabicText,
      textAlign: TextAlign.right,
      textDirection: TextDirection.rtl,
      style: TextStyle(
        fontFamily: 'Uthmani',
        fontSize: 24,
        height: 1.8,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
