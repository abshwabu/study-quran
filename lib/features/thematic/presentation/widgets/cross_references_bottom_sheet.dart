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
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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

  Color _getRelationshipColor(String type) {
    switch (type) {
      case 'similar_theme':
        return Colors.teal;
      case 'same_story':
        return Colors.blue;
      case 'similar_wording':
        return Colors.purple;
      case 'scholarly_abrogation_naskh':
        return Colors.amber.shade900;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final crossRefsAsync = ref.watch(crossReferencesForAyahProvider((
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
                    'Cross-References ($surahNumber:$ayahNumber)',
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

              crossRefsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text('Error loading cross references: $err')),
                data: (crossRefs) {
                  if (crossRefs.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: Column(
                        children: [
                          Icon(Icons.compare_arrows, size: 48, color: Colors.grey),
                          SizedBox(height: 12),
                          Text(
                            'No explicit cross-references recorded for this ayah.',
                            style: TextStyle(color: Colors.grey),
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
                            color: Colors.amber.shade50,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.amber.shade300),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.gavel, color: Colors.amber.shade900),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Scholarly Disclaimer: Abrogation (Naskh) is subject to scholarly debate. Entries reflect classical commentary works (e.g. Al-Nasikh wal-Mansukh), presented for academic research.',
                                  style: TextStyle(fontSize: 12, color: Colors.amber.shade900, height: 1.3),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],

                      ...crossRefs.map((item) {
                        final type = item.crossRef.relationshipType;
                        final color = _getRelationshipColor(type);
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
                                    Chip(
                                      backgroundColor: color.withValues(alpha: 0.1),
                                      avatar: Icon(Icons.link, size: 14, color: color),
                                      label: Text(
                                        label,
                                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color),
                                      ),
                                    ),
                                    Text(
                                      'Surah ${item.targetSurahNameTranslit} (${item.crossRef.targetSurah}:${item.crossRef.targetAyah})',
                                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),

                                Text(
                                  item.targetArabicText,
                                  textAlign: TextAlign.right,
                                  textDirection: TextDirection.rtl,
                                  style: const TextStyle(
                                    fontFamily: 'Uthmani',
                                    fontSize: 18,
                                    height: 1.6,
                                  ),
                                ),
                                if (item.targetTranslationText != null) ...[
                                  const SizedBox(height: 6),
                                  Text(
                                    item.targetTranslationText!,
                                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                                  ),
                                ],
                                if (item.crossRef.notes.isNotEmpty) ...[
                                  const SizedBox(height: 6),
                                  Text(
                                    'Note: ${item.crossRef.notes}',
                                    style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.grey),
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
