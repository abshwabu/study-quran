import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/thematic_providers.dart';
import '../../../quran_reader/presentation/quran_reader_screen.dart';

class CrossReferencesBottomSheet extends ConsumerWidget {
  final int surahNumber;
  final int ayahNumber;

  const CrossReferencesBottomSheet({
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
      builder: (ctx) => CrossReferencesBottomSheet(surahNumber: surahNumber, ayahNumber: ayahNumber),
    );
  }

  String _formatRelationshipLabel(String type) {
    switch (type) {
      case 'similar_theme':
        return 'Similar Theme / Concept';
      case 'same_story':
        return 'Same Narrative / Story';
      case 'similar_wording':
        return 'Similar Phrasing / Wording';
      case 'scholarly_abrogation_naskh':
        return 'Scholarly Abrogation (Naskh)';
      default:
        return type.replaceAll('_', ' ').toUpperCase();
    }
  }

  Color _getRelationshipColor(String type, ColorScheme colorScheme) {
    switch (type) {
      case 'similar_theme':
        return colorScheme.primary;
      case 'same_story':
        return Colors.blue;
      case 'similar_wording':
        return const Color(0xFFAB47BC);
      case 'scholarly_abrogation_naskh':
        return colorScheme.secondary;
      default:
        return colorScheme.onSurfaceVariant;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final crossRefsAsync = ref.watch(crossReferencesForAyahProvider((
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
                    'Cross-References ($surahNumber:$ayahNumber)',
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

              crossRefsAsync.when(
                loading: () => Center(child: CircularProgressIndicator(color: colorScheme.primary)),
                error: (err, stack) => Center(child: Text('Error loading cross references: $err')),
                data: (crossRefs) {
                  if (crossRefs.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Column(
                        children: [
                          Icon(Icons.compare_arrows, size: 48, color: colorScheme.onSurfaceVariant),
                          const SizedBox(height: 12),
                          Text(
                            'No explicit cross-references recorded for this ayah.',
                            style: TextStyle(color: colorScheme.onSurfaceVariant),
                          ),
                        ],
                      ),
                    );
                  }

                  final hasNaskh = crossRefs.any((c) => c.crossRef.relationshipType == 'scholarly_abrogation_naskh');

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Scholarly Disclaimer Banner for Abrogation (Naskh)
                      if (hasNaskh) ...[
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: colorScheme.secondary.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: colorScheme.secondary.withValues(alpha: 0.3)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.gavel, color: colorScheme.secondary),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Scholarly Disclaimer: Abrogation (Naskh) is subject to scholarly debate. Entries reflect classical commentary works (e.g. Al-Nasikh wal-Mansukh), presented for academic research.',
                                  style: TextStyle(fontSize: 12, color: colorScheme.secondary, height: 1.3),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],

                      ...crossRefs.map((item) {
                        final type = item.crossRef.relationshipType;
                        final color = _getRelationshipColor(type, colorScheme);
                        final label = _formatRelationshipLabel(type);

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
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
                                        color: color.withValues(alpha: 0.12),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.link, size: 14, color: color),
                                          const SizedBox(width: 4),
                                          Text(
                                            label,
                                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      'Surah ${item.targetSurahNameTranslit} (${item.crossRef.targetSurah}:${item.crossRef.targetAyah})',
                                      style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.primary),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),

                                Text(
                                  item.targetArabicText,
                                  textAlign: TextAlign.right,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    fontFamily: 'Uthmani',
                                    fontSize: 18,
                                    height: 1.6,
                                    color: colorScheme.onSurface,
                                  ),
                                ),
                                if (item.targetTranslationText != null) ...[
                                  const SizedBox(height: 6),
                                  Text(
                                    item.targetTranslationText!,
                                    style: TextStyle(fontSize: 13, color: colorScheme.onSurfaceVariant),
                                  ),
                                ],
                                if (item.crossRef.notes.isNotEmpty) ...[
                                  const SizedBox(height: 6),
                                  Text(
                                    'Note: ${item.crossRef.notes}',
                                    style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: colorScheme.onSurfaceVariant),
                                  ),
                                ],
                                const SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextButton.icon(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (ctx) => const QuranReaderScreen(),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.open_in_new, size: 16),
                                    label: const Text('Jump to Ayah'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
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
