import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/providers.dart';
import '../providers/tafsir_providers.dart';

import '../../content_packs/presentation/content_pack_manager_screen.dart';

class TafsirLibraryScreen extends ConsumerWidget {
  const TafsirLibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metaAsync = ref.watch(availableTafsirsMetaProvider);
    final packsAsync = ref.watch(availableContentPacksProvider);
    final defaultId = ref.watch(defaultTafsirIdProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tafsir Library'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            tooltip: 'Content Pack Downloader',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const ContentPackManagerScreen(),
                ),
              );
            },
          ),
        ],
      ),

      body: metaAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error loading Tafsirs: $err')),
        data: (tafsirMetas) {
          final packs = packsAsync.value ?? [];

          // Group by language
          final grouped = <String, List<dynamic>>{};
          for (final meta in tafsirMetas) {
            grouped.putIfAbsent(meta.language.toUpperCase(), () => []).add(meta);
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Card(
                elevation: 0,
                color: Color(0xFFF0F7FF),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(Icons.library_books, color: Colors.blue),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Select your default Tafsir for quick per-ayah reading or download additional classical commentary packs.',
                          style: TextStyle(fontSize: 13, color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ...grouped.entries.map((entry) {
                final lang = entry.key;
                final metas = entry.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                      child: Text(
                        '$lang Tafsirs',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                    ...metas.map((meta) {
                      final isDefault = meta.tafsirId == defaultId;
                      final pack = packs.firstWhere(
                        (p) => p.packId == meta.tafsirId,
                        orElse: () => packs.first,
                      );

                      final isDownloaded = meta.tafsirId == 'ar.muyassar' || meta.tafsirId == 'en.jalalayn';

                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          title: Text(
                            meta.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${meta.author} • Source: ${meta.source}'),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Chip(
                                    labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    visualDensity: VisualDensity.compact,
                                    backgroundColor: isDownloaded ? Colors.green.shade50 : Colors.orange.shade50,
                                    label: Text(
                                      isDownloaded ? 'Downloaded' : 'Available (${(pack.sizeBytes / (1024 * 1024)).toStringAsFixed(1)} MB)',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: isDownloaded ? Colors.green.shade800 : Colors.orange.shade800,
                                      ),
                                    ),
                                  ),
                                  if (isDefault) ...[
                                    const SizedBox(width: 8),
                                    const Chip(
                                      labelPadding: EdgeInsets.symmetric(horizontal: 4),
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: VisualDensity.compact,
                                      backgroundColor: Colors.blueAccent,
                                      label: Text(
                                        'Default',
                                        style: TextStyle(fontSize: 11, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  isDefault ? Icons.check_circle : Icons.radio_button_unchecked,
                                  color: isDefault ? Colors.teal : Colors.grey,
                                ),
                                tooltip: 'Set as Default Tafsir',
                                onPressed: () {
                                  ref.read(defaultTafsirIdProvider.notifier).setDefaultTafsir(meta.tafsirId);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 12),
                  ],
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
