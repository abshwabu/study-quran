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
    final colorScheme = Theme.of(context).colorScheme;
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
                    final isCurrent = meta.tafsirId == _activeTafsirId;
                    return PopupMenuItem<String>(
                      value: meta.tafsirId,
                      child: Row(
                        children: [
                          Icon(
                            isCurrent ? Icons.check : Icons.book_outlined,
                            size: 18,
                            color: isCurrent ? colorScheme.primary : colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            meta.name,
                            style: TextStyle(
                              fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                              color: isCurrent ? colorScheme.primary : colorScheme.onSurface,
                            ),
                          ),
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
                    initialSelectedTafsirIds: [
                      _activeTafsirId,
                      if (_activeTafsirId == 'ar.muyassar') 'en.jalalayn' else 'ar.muyassar',
                    ],
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
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
              border: Border(bottom: BorderSide(color: colorScheme.outlineVariant)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${surahMeta?.nameTranslit ?? "Surah"} $_currentSurah:$_currentAyah',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                    Text(
                      surahMeta?.nameArabic ?? '',
                      style: TextStyle(
                        fontFamily: 'Amiri',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  currentAyahData?.ayah.arabicTextUthmani ?? '',
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: 'Uthmani',
                    fontSize: 22,
                    height: 1.8,
                    color: colorScheme.onSurface,
                  ),
                ),
                if (currentAyahData?.translationText != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    currentAyahData!.translationText!,
                    style: TextStyle(
                      fontSize: 14,
                      color: colorScheme.onSurfaceVariant,
                      height: 1.45,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Commentary Body
          Expanded(
            child: commentaryAsync.when(
              loading: () => Center(child: CircularProgressIndicator(color: colorScheme.primary)),
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
                          Icon(Icons.info_outline, size: 48, color: colorScheme.onSurfaceVariant),
                          const SizedBox(height: 12),
                          Text(
                            'No commentary found for Ayah $_currentSurah:$_currentAyah in this Tafsir.',
                            style: TextStyle(color: colorScheme.onSurfaceVariant),
                          ),
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
                        Icon(Icons.auto_stories, color: colorScheme.primary),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            entry.meta.name,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Author: ${entry.meta.author} • Language: ${entry.meta.language.toUpperCase()}',
                      style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
                    ),
                    if (isRange) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: colorScheme.secondary.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Range Commentary: Ayahs ${entry.content.startAyah}–${entry.content.endAyah}',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: colorScheme.secondary),
                        ),
                      ),
                    ],
                    const Divider(height: 24),
                    Text(
                      entry.content.textContent,
                      textDirection: entry.meta.language == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                      style: TextStyle(
                        fontSize: entry.meta.language == 'ar' ? 18 : 15,
                        height: 1.7,
                        color: colorScheme.onSurface,
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
            decoration: BoxDecoration(
              color: colorScheme.surface,
              border: Border(top: BorderSide(color: colorScheme.outlineVariant)),
            ),
            child: SafeArea(
              top: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton.icon(
                    onPressed: _currentAyah > 1 ? () => _navigateAyah(-1) : null,
                    icon: const Icon(Icons.arrow_back_ios_new, size: 14),
                    label: const Text('Prev Ayah'),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Ayah $_currentAyah',
                      style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.primary),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: (surahMeta != null && _currentAyah < surahMeta.ayahCount) ? () => _navigateAyah(1) : null,
                    iconAlignment: IconAlignment.end,
                    icon: const Icon(Icons.arrow_forward_ios, size: 14),
                    label: const Text('Next Ayah'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
