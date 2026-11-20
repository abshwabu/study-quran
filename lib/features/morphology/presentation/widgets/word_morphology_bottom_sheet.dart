import 'package:flutter/material.dart';
import 'package:studyquran/core/database/daos/quran_dao.dart';
import '../../../search/presentation/root_concordance_screen.dart';

class WordMorphologyBottomSheet extends StatelessWidget {
  final WordWithRoot wordData;

  const WordMorphologyBottomSheet({
    super.key,
    required this.wordData,
  });

  static void show(BuildContext context, WordWithRoot wordData) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => WordMorphologyBottomSheet(wordData: wordData),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final word = wordData.word;
    final root = wordData.root;

    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 8, left: 20, right: 20, bottom: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Close Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Word Grammar & Morphology',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: colorScheme.onSurface),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Divider(color: colorScheme.outlineVariant),
              const SizedBox(height: 8),

              // Arabic Word Header
              Center(
                child: Column(
                  children: [
                    Text(
                      word.arabicText,
                      style: TextStyle(
                        fontFamily: 'Uthmani',
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      word.transliteration,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: colorScheme.secondary),
                    ),
                    if (word.translationGloss.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        '"${word.translationGloss}"',
                        style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic, color: colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Part of Speech Badge
              if (word.partOfSpeech.isNotEmpty) ...[
                Text(
                  'Part of Speech',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: colorScheme.primary),
                ),
                const SizedBox(height: 6),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFF8E24AA).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.label, size: 14, color: Color(0xFF8E24AA)),
                        const SizedBox(width: 6),
                        Text(
                          word.partOfSpeech,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF8E24AA), fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Grammatical Analysis
              if (word.grammarDetails.isNotEmpty) ...[
                Text(
                  'Grammatical Analysis (I\'rab)',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: colorScheme.primary),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colorScheme.outlineVariant),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.menu_book, color: colorScheme.primary, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          word.grammarDetails,
                          style: TextStyle(fontSize: 14, height: 1.4, color: colorScheme.onSurface),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Arabic Root Details & Concordance
              if (root != null) ...[
                Text(
                  'Arabic Root',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: colorScheme.primary),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colorScheme.outlineVariant),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Root: ${root.rootArabic} (${root.rootTranslit})',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: colorScheme.primary),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: colorScheme.secondary.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '${root.occurrenceCount} occurrences',
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: colorScheme.secondary),
                            ),
                          ),
                        ],
                      ),
                      if (root.meaningsSummary.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Text(
                          'Meaning: ${root.meaningsSummary}',
                          style: TextStyle(fontSize: 13, color: colorScheme.onSurfaceVariant),
                        ),
                      ],
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => RootConcordanceScreen(rootArabic: root.rootArabic),
                              ),
                            );
                          },
                          icon: const Icon(Icons.manage_search, size: 18),
                          label: const Text('See All Occurrences of This Root'),
                        ),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                // Graceful fallback for words without indexed root
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: colorScheme.onSurfaceVariant),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Full morphological corpus and root analysis pack available for download in Content Packs.',
                          style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
