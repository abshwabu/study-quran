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
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => AsbabAlNuzulBottomSheet(surahNumber: surahNumber, ayahNumber: ayahNumber),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final asbabAsync = ref.watch(asbabAlNuzulForAyahProvider((
      surahNumber: surahNumber,
      ayahNumber: ayahNumber,
    )));

    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Asbab al-Nuzul ($surahNumber:$ayahNumber)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: colorScheme.onSurface),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Divider(color: colorScheme.outlineVariant),
              const SizedBox(height: 8),

              asbabAsync.when(
                loading: () => Center(child: CircularProgressIndicator(color: colorScheme.primary)),
                error: (err, stack) => Center(child: Text('Error loading Asbab al-Nuzul: $err')),
                data: (entry) {
                  if (entry == null) {
                    return Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: colorScheme.outlineVariant),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.history_edu, size: 48, color: colorScheme.onSurfaceVariant),
                          const SizedBox(height: 12),
                          const Text(
                            'No Specific Occasion of Revelation Recorded',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Not every Quranic verse was revealed in response to a specific historical event. Many verses convey general guidance, laws, or universal truths.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 13),
                          ),
                        ],
                      ),
                    );
                  }

                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: colorScheme.primary.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.menu_book, size: 14, color: colorScheme.primary),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Range: Ayahs ${entry.startAyah}–${entry.endAyah}',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: colorScheme.primary),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          entry.textContent,
                          style: TextStyle(fontSize: 15, height: 1.6, color: colorScheme.onSurface),
                        ),
                        const SizedBox(height: 16),
                        Divider(color: colorScheme.outlineVariant),
                        Row(
                          children: [
                            Icon(Icons.source, size: 16, color: colorScheme.primary),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                'Source: ${entry.sourceNote}',
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: colorScheme.primary),
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
