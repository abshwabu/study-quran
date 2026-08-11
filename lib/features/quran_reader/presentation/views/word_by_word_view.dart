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
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: ayahs.length,
      separatorBuilder: (context, index) => const Divider(height: 32),
      itemBuilder: (context, index) {
        final ayahData = ayahs[index];
        final wordsAsync = ref.watch(wordsForAyahProvider((
          surahNumber: ayahData.ayah.surahNumber,
          ayahNumber: ayahData.ayah.ayahNumber,
        )));

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Ayah Number Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  avatar: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Text(
                      '${ayahData.ayah.ayahNumber}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  label: Text('Ayah ${ayahData.ayah.ayahNumber}'),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () => onAyahSelected(ayahData),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Word-by-Word Wrapped Flow
            wordsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => _FallbackAyahText(arabicText: ayahData.ayah.arabicTextUthmani),
              data: (wordsList) {
                if (wordsList.isEmpty) {
                  return _FallbackAyahText(arabicText: ayahData.ayah.arabicTextUthmani);
                }

                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 12,
                    alignment: WrapAlignment.start,
                    children: wordsList.map((wordData) {
                      final word = wordData.word;

                      return InkWell(
                        onTap: () => WordMorphologyBottomSheet.show(context, wordData),
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.5),
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
                                  color: const Color(0xFF1B5E20),
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
                                    color: Colors.teal.shade800,
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
                                      color: Colors.black87,
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

              const SizedBox(height: 16),
              Text(
                ayahData.translationText!,
                style: TextStyle(
                  fontSize: preferences.translationFontSize,
                  height: 1.5,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ],
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
      style: const TextStyle(
        fontFamily: 'Uthmani',
        fontSize: 24,
        height: 1.8,
      ),
    );
  }
}
