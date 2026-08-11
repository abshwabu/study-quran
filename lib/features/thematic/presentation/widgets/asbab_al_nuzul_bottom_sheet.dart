import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/thematic_providers.dart';

class AsbabAlNuzulBottomSheet extends ConsumerWidget {
  final int surahNumber;
  final int ayahNumber;

  const AsbabAlNuzulBottomSheet({
    super.key,
    required this.surahNumber,
    required this.ayahNumber,
  });

  static void show(BuildContext context, {required int surahNumber, required int ayahNumber}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => AsbabAlNuzulBottomSheet(surahNumber: surahNumber, ayahNumber: ayahNumber),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asbabAsync = ref.watch(asbabAlNuzulForAyahProvider((
      surahNumber: surahNumber,
      ayahNumber: ayahNumber,
    )));

    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Asbab al-Nuzul ($surahNumber:$ayahNumber)',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 8),

              asbabAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text('Error loading Asbab al-Nuzul: $err')),
                data: (entry) {
                  if (entry == null) {
                    return Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Column(
                        children: [
                          Icon(Icons.history_edu, size: 48, color: Colors.grey),
                          SizedBox(height: 12),
                          Text(
                            'No Specific Occasion of Revelation Recorded',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Not every Quranic verse was revealed in response to a specific historical event. Many verses convey general guidance, laws, or universal truths.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                        ],
                      ),
                    );
                  }

                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Chip(
                              avatar: const Icon(Icons.menu_book, size: 14),
                              label: Text('Range: Ayahs ${entry.startAyah}–${entry.endAyah}'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          entry.textContent,
                          style: const TextStyle(fontSize: 15, height: 1.6, color: Colors.black87),
                        ),
                        const SizedBox(height: 16),
                        const Divider(),
                        Row(
                          children: [
                            const Icon(Icons.source, size: 16, color: Colors.teal),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                'Source: ${entry.sourceNote}',
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.teal),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
