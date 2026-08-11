import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/thematic_providers.dart';
import '../../../core/database/app_database.dart';
import '../../quran_reader/presentation/quran_reader_screen.dart';

class TopicDetailScreen extends ConsumerWidget {
  final Topic topic;

  const TopicDetailScreen({
    super.key,
    required this.topic,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ayahsAsync = ref.watch(topicAyahsProvider(topic.topicId));

    return Scaffold(
      appBar: AppBar(
        title: Text(topic.name),
      ),
      body: ayahsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error loading topic ayahs: $err')),
        data: (ayahs) {
          if (ayahs.isEmpty) {
            return const Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.category, size: 48, color: Colors.grey),
                    SizedBox(height: 12),
                    Text('No ayahs currently mapped to this topic entry.'),
                  ],
                ),
              ),
            );
          }

          return Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.4),
                child: Column(
                  children: [
                    Text(
                      topic.name,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Chip(
                      visualDensity: VisualDensity.compact,
                      label: Text('${ayahs.length} verses linked to this topic'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: ayahs.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = ayahs[index];

                    return Card(
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
