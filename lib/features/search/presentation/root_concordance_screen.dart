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
    final colorScheme = Theme.of(context).colorScheme;
    final concordanceAsync = ref.watch(rootConcordanceProvider(rootArabic));

    return Scaffold(
      appBar: AppBar(
        title: Text('Root Concordance: $rootArabic'),
      ),
      body: concordanceAsync.when(
        loading: () => Center(child: CircularProgressIndicator(color: colorScheme.primary)),
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
                    Icon(Icons.blur_on, size: 56, color: colorScheme.primary),
                    const SizedBox(height: 16),
                    Text(
                      'Root: $rootArabic',
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Morphology dataset index loaded. Selected root occurrences found in indexed core text.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: colorScheme.onSurfaceVariant),
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
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer.withValues(alpha: 0.5),
                  border: Border(bottom: BorderSide(color: colorScheme.outlineVariant)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.auto_awesome, color: colorScheme.secondary),
                        const SizedBox(width: 8),
                        Text(
                          'Root: $rootArabic',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: colorScheme.primary),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Found ${occurrences.length} occurrences in indexed Quranic morphology',
                      style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.onPrimaryContainer),
                    ),
                  ],
                ),
              ),

              // Verses List
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: occurrences.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = occurrences[index];

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: colorScheme.primaryContainer,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '${item.surahNameTranslit} (${item.surahNumber}:${item.ayahNumber})',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: colorScheme.primary,
                                    ),
                                  ),
                                ),
                                Text(
                                  item.surahNameArabic,
                                  style: TextStyle(
                                    fontFamily: 'Amiri',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),

                            // Arabic Uthmani Text
                            Text(
                              item.arabicTextUthmani,
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontFamily: 'Uthmani',
                                fontSize: 20,
                                height: 1.8,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Matched Word Badge
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: colorScheme.secondary.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: colorScheme.secondary.withValues(alpha: 0.3)),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.find_in_page, size: 14, color: colorScheme.secondary),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Matched Word: ${item.matchedWord} (Position ${item.wordPosition})',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: colorScheme.secondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            if (item.translationText != null) ...[
                              Divider(height: 16, color: colorScheme.outlineVariant),
                              Text(
                                item.translationText!,
                                style: TextStyle(fontSize: 14, color: colorScheme.onSurfaceVariant),
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
