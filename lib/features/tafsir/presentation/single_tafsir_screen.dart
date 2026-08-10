import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/providers.dart';
import '../providers/tafsir_providers.dart';
import 'tafsir_comparison_screen.dart';

class SingleTafsirScreen extends ConsumerStatefulWidget {
  final int surahNumber;
  final int ayahNumber;
  final String? initialTafsirId;

  const SingleTafsirScreen({
    super.key,
    required this.surahNumber,
    required this.ayahNumber,
    this.initialTafsirId,
  });

  @override
  ConsumerState<SingleTafsirScreen> createState() => _SingleTafsirScreenState();
}

class _SingleTafsirScreenState extends ConsumerState<SingleTafsirScreen> {
  late int _currentSurah;
  late int _currentAyah;
  late String _activeTafsirId;

  @override
  void initState() {
    super.initState();
    _currentSurah = widget.surahNumber;
    _currentAyah = widget.ayahNumber;
    _activeTafsirId = widget.initialTafsirId ?? ref.read(defaultTafsirIdProvider);
  }

  void _navigateAyah(int direction) {
    final nextAyah = _currentAyah + direction;
    if (nextAyah >= 1) {
      setState(() {
        _currentAyah = nextAyah;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final metaListAsync = ref.watch(availableTafsirsMetaProvider);
    final surahsAsync = ref.watch(surahsProvider);
    final ayahsAsync = ref.watch(surahDetailProvider(_currentSurah));

    final commentaryAsync = ref.watch(
      singleTafsirCommentaryProvider((
        tafsirId: _activeTafsirId,
        surahNumber: _currentSurah,
        ayahNumber: _currentAyah,
      )),
    );

    final surahMeta = surahsAsync.value?.firstWhere(
      (s) => s.number == _currentSurah,
      orElse: () => surahsAsync.value?.first ?? surahsAsync.value![0],
    );

    final currentAyahData = ayahsAsync.value?.firstWhere(
      (a) => a.ayah.ayahNumber == _currentAyah,
      orElse: () => ayahsAsync.value?.first ?? ayahsAsync.value![0],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('${surahMeta?.nameTranslit ?? "Surah $_currentSurah"} ($_currentSurah:$_currentAyah)'),
        actions: [
          metaListAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
            data: (metas) {
              return PopupMenuButton<String>(
                icon: const Icon(Icons.swap_horiz),
                tooltip: 'Switch Tafsir',
                onSelected: (selectedId) {
                  setState(() {
                    _activeTafsirId = selectedId;
                  });
                },
                itemBuilder: (context) {
                  return metas.map((meta) {
                    return PopupMenuItem<String>(
                      value: meta.tafsirId,
                      child: Row(
                        children: [
                          Icon(
                            meta.tafsirId == _activeTafsirId ? Icons.check : Icons.book_outlined,
                            size: 18,
                            color: meta.tafsirId == _activeTafsirId ? Colors.teal : Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Text(meta.name),
                        ],
                      ),
                    );
                  }).toList();
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.compare_arrows),
            tooltip: 'Compare Tafsirs',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TafsirComparisonScreen(
                    surahNumber: _currentSurah,
                    ayahNumber: _currentAyah,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Header: Ayah Arabic & Translation Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Chip(
                      label: Text('${surahMeta?.nameTranslit ?? "Surah"} $_currentSurah:$_currentAyah'),
                      visualDensity: VisualDensity.compact,
                    ),
                    Text(
                      surahMeta?.nameArabic ?? '',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  currentAyahData?.ayah.arabicTextUthmani ?? '',
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                    fontFamily: 'Uthmani',
                    fontSize: 22,
                    height: 1.8,
                  ),
                ),
                if (currentAyahData?.translationText != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    currentAyahData!.translationText!,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ],
            ),
          ),

          // Commentary Body
          Expanded(
            child: commentaryAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('Error loading commentary: $err'),
                ),
              ),
              data: (entry) {
                if (entry == null) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.info_outline, size: 48, color: Colors.grey),
                          const SizedBox(height: 12),
                          Text('No commentary found for Ayah $_currentSurah:$_currentAyah in this Tafsir.'),
                        ],
                      ),
                    ),
                  );
                }

                final isRange = entry.content.startAyah != entry.content.endAyah;

                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Row(
                      children: [
                        Icon(Icons.auto_stories, color: Theme.of(context).colorScheme.primary),
                        const SizedBox(width: 8),
                        Text(
                          entry.meta.name,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Author: ${entry.meta.author} • Language: ${entry.meta.language.toUpperCase()}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    if (isRange) ...[
                      const SizedBox(height: 8),
                      Chip(
                        avatar: const Icon(Icons.linear_scale, size: 16),
                        backgroundColor: Colors.amber.shade100,
                        label: Text('Range Commentary: Ayahs ${entry.content.startAyah}–${entry.content.endAyah}'),
                      ),
                    ],
                    const Divider(height: 24),
                    Text(
                      entry.content.textContent,
                      textDirection: entry.meta.language == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                      style: TextStyle(
                        fontSize: entry.meta.language == 'ar' ? 18 : 15,
                        height: 1.7,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // Footer Navigation
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: _currentAyah > 1 ? () => _navigateAyah(-1) : null,
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Prev Ayah'),
                ),
                Text(
                  'Ayah $_currentAyah',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: (surahMeta != null && _currentAyah < surahMeta.ayahCount) ? () => _navigateAyah(1) : null,
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Next Ayah'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
