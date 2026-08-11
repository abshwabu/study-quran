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
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => WordMorphologyBottomSheet(wordData: wordData),
    );
  }

  @override
  Widget build(BuildContext context) {
    final word = wordData.word;
    final root = wordData.root;

    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Close Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Word Grammar & Morphology', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 8),

              // Arabic Word Header
              Center(
                child: Column(
                  children: [
                    Text(
                      word.arabicText,
                      style: const TextStyle(
                        fontFamily: 'Uthmani',
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B5E20),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      word.transliteration,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
                    ),
                    if (word.translationGloss.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        '"${word.translationGloss}"',
                        style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.black87),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Part of Speech Badge
              if (word.partOfSpeech.isNotEmpty) ...[
                const Text('Part of Speech', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey)),
                const SizedBox(height: 6),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Chip(
                    avatar: const Icon(Icons.label, size: 14, color: Colors.purple),
                    backgroundColor: Colors.purple.shade50,
                    label: Text(
                      word.partOfSpeech,
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple.shade900),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Grammatical Analysis
              if (word.grammarDetails.isNotEmpty) ...[
                const Text('Grammatical Analysis (I\'rab)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey)),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.menu_book, color: Colors.teal),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          word.grammarDetails,
                          style: const TextStyle(fontSize: 14, height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Arabic Root Details & Concordance
              if (root != null) ...[
                const Text('Arabic Root', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey)),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade50,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.amber.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Root: ${root.rootArabic} (${root.rootTranslit})',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber.shade900),
                          ),
                          Chip(
                            visualDensity: VisualDensity.compact,
                            label: Text('${root.occurrenceCount} occurrences'),
                          ),
                        ],
                      ),
                      if (root.meaningsSummary.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Text(
                          'Meaning: ${root.meaningsSummary}',
                          style: const TextStyle(fontSize: 13, color: Colors.black87),
                        ),
                      ],
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber.shade800,
                            foregroundColor: Colors.white,
                          ),
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
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.grey.shade600),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Full morphological corpus and root analysis pack available for download in Content Packs.',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
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
