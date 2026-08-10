import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/search_providers.dart';
import '../../quran_reader/presentation/quran_reader_screen.dart';

class RootConcordanceScreen extends ConsumerWidget {
  final String rootArabic;

  const RootConcordanceScreen({
    super.key,
    required this.rootArabic,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final concordanceAsync = ref.watch(rootConcordanceProvider(rootArabic));

    return Scaffold(
      appBar: AppBar(
        title: Text('Root Concordance: $rootArabic'),
      ),
      body: concordanceAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Error loading root concordance: $err'),
          ),
        ),
        data: (occurrences) {
          if (occurrences.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.blur_on, size: 56, color: Colors.teal),
                    const SizedBox(height: 16),
                    Text(
                      'Root: $rootArabic',
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Morphology dataset index loaded. Selected root occurrences found in indexed core text.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          }

          return Column(
            children: [
              // Header Summary Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.4),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.auto_awesome, color: Colors.teal),
                        const SizedBox(width: 8),
                        Text(
                          'Root: $rootArabic',
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Found ${occurrences.length} occurrences in indexed Quranic morphology',
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
                    ),
                  ],
                ),
              ),

              // Verses List
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: occurrences.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = occurrences[index];

                    return Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Chip(
                                  label: Text('${item.surahNameTranslit} (${item.surahNumber}:${item.ayahNumber})'),
                                  visualDensity: VisualDensity.compact,
                                ),
                                Text(
                                  item.surahNameArabic,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            // Arabic Uthmani Text
                            Text(
                              item.arabicTextUthmani,
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,

                              style: const TextStyle(
                                fontFamily: 'Uthmani',
                                fontSize: 20,
                                height: 1.8,
                              ),
                            ),
                            const SizedBox(height: 6),

                            // Matched Word Badge
                            Align(
                              alignment: Alignment.centerRight,
                              child: Chip(
                                avatar: const Icon(Icons.find_in_page, size: 14),
                                backgroundColor: Colors.amber.shade100,
                                label: Text('Matched Word: ${item.matchedWord} (Position ${item.wordPosition})'),
                              ),
                            ),

                            if (item.translationText != null) ...[
                              const Divider(height: 16),
                              Text(
                                item.translationText!,
                                style: const TextStyle(fontSize: 14, color: Colors.black87),
                              ),
                            ],

                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton.icon(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (ctx) => const QuranReaderScreen(),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.open_in_new, size: 16),
                                label: const Text('Read in Context'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
