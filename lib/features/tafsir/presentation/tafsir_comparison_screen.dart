import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/providers.dart';
import '../../content_packs/presentation/content_pack_manager_screen.dart';
import '../../../core/content_packs/services/content_pack_download_service.dart';
import '../../quran_reader/presentation/widgets/jump_to_dialog.dart';
import '../providers/tafsir_providers.dart';

class TafsirComparisonScreen extends ConsumerStatefulWidget {
  final int surahNumber;
  final int ayahNumber;
  final List<String>? initialSelectedTafsirIds;

  const TafsirComparisonScreen({
    super.key,
    required this.surahNumber,
    required this.ayahNumber,
    this.initialSelectedTafsirIds,
  });

  @override
  ConsumerState<TafsirComparisonScreen> createState() => _TafsirComparisonScreenState();
}

class _TafsirComparisonScreenState extends ConsumerState<TafsirComparisonScreen> {
  late int _currentSurah;
  late int _currentAyah;
  late Set<String> _selectedTafsirIds;

  @override
  void initState() {
    super.initState();
    _currentSurah = widget.surahNumber;
    _currentAyah = widget.ayahNumber;

    if (widget.initialSelectedTafsirIds != null && widget.initialSelectedTafsirIds!.isNotEmpty) {
      _selectedTafsirIds = Set.from(widget.initialSelectedTafsirIds!);
    } else {
      // Default to comparing the pre-bundled ar.muyassar and en.jalalayn
      _selectedTafsirIds = {'ar.muyassar', 'en.jalalayn'};
    }
  }

  void _toggleTafsirSelection(String tafsirId) {
    setState(() {
      if (_selectedTafsirIds.contains(tafsirId)) {
        if (_selectedTafsirIds.length > 1) {
          _selectedTafsirIds.remove(tafsirId);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('At least one Tafsir must remain selected.'),
              duration: Duration(seconds: 1),
            ),
          );
        }
      } else {
        _selectedTafsirIds.add(tafsirId);
      }
    });
  }

  void _navigateAyah(int delta, int maxAyahs) {
    final target = _currentAyah + delta;
    if (target >= 1 && target <= maxAyahs) {
      setState(() {
        _currentAyah = target;
      });
    }
  }

  void _openJumpDialog() {
    JumpToDialog.show(
      context,
      initialSurah: _currentSurah,
      initialAyah: _currentAyah,
      onJump: (surah, ayah) {
        setState(() {
          _currentSurah = surah;
          _currentAyah = ayah;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final metaListAsync = ref.watch(availableTafsirsMetaProvider);
    final downloadedIdsAsync = ref.watch(downloadedTafsirIdsProvider);
    final surahsAsync = ref.watch(surahsProvider);
    final ayahsAsync = ref.watch(surahDetailProvider(_currentSurah));

    final comparisonAsync = ref.watch(
      comparisonTafsirsProvider(
        ComparisonQueryParam(
          tafsirIds: _selectedTafsirIds.toList(),
          surahNumber: _currentSurah,
          ayahNumber: _currentAyah,
        ),
      ),
    );

    final surahMeta = surahsAsync.value?.firstWhere(
      (s) => s.number == _currentSurah,
      orElse: () => surahsAsync.value?.first ?? surahsAsync.value![0],
    );

    final currentAyahData = ayahsAsync.value?.firstWhere(
      (a) => a.ayah.ayahNumber == _currentAyah,
      orElse: () => ayahsAsync.value?.first ?? ayahsAsync.value![0],
    );

    final downloadedIds = downloadedIdsAsync.value ?? const ['ar.muyassar', 'en.jalalayn'];
    final maxAyahs = surahMeta?.ayahCount ?? 286;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Compare Tafsirs',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '${surahMeta?.nameTranslit ?? "Surah $_currentSurah"} ($_currentSurah:$_currentAyah)',
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.pin_drop_outlined),
            tooltip: 'Jump to Ayah',
            onPressed: _openJumpDialog,
          ),
          IconButton(
            icon: const Icon(Icons.download_outlined),
            tooltip: 'Content Packs',
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const ContentPackManagerScreen(),
                ),
              );
              ref.invalidate(downloadedTafsirIdsProvider);
              ref.invalidate(comparisonTafsirsProvider);
              ref.invalidate(availableContentPacksProvider);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Ayah Arabic Header Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              border: Border(bottom: BorderSide(color: colorScheme.outlineVariant)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  currentAyahData?.ayah.arabicTextUthmani ?? '',
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: 'Uthmani',
                    fontSize: 20,
                    height: 1.7,
                    color: colorScheme.onSurface,
                  ),
                ),
                if (currentAyahData?.translationText != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    currentAyahData!.translationText!,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.4,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Selector Filter Chips
          metaListAsync.when(
            loading: () => const SizedBox(height: 48),
            error: (_, __) => const SizedBox.shrink(),
            data: (metas) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: metas.map((meta) {
                      final isSelected = _selectedTafsirIds.contains(meta.tafsirId);
                      final isDownloaded = downloadedIds.contains(meta.tafsirId);

                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          selected: isSelected,
                          avatar: isDownloaded
                              ? null
                              : Icon(
                                  Icons.cloud_outlined,
                                  size: 16,
                                  color: isSelected ? colorScheme.onPrimaryContainer : colorScheme.outline,
                                ),
                          label: Text(
                            meta.name,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                          selectedColor: colorScheme.primaryContainer,
                          onSelected: (_) => _toggleTafsirSelection(meta.tafsirId),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
          Divider(height: 1, color: colorScheme.outlineVariant),

          // Comparison List / Columns Body
          Expanded(
            child: comparisonAsync.when(
              loading: () => Center(
                child: CircularProgressIndicator(color: colorScheme.primary),
              ),
              error: (err, stack) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.error_outline, size: 40, color: colorScheme.error),
                      const SizedBox(height: 12),
                      Text('Error loading comparison: $err', textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
              data: (items) {
                if (items.isEmpty) {
                  return Center(
                    child: Text(
                      'No Tafsir selected for comparison.',
                      style: TextStyle(color: colorScheme.onSurfaceVariant),
                    ),
                  );
                }

                return LayoutBuilder(
                  builder: (context, constraints) {
                    final isWideScreen = constraints.maxWidth >= 700;

                    if (isWideScreen) {
                      // Side-by-Side Column Layout for Tablets / Wide Screens
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: items.map((item) {
                          return Expanded(
                            child: Card(
                              margin: const EdgeInsets.all(8),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(color: colorScheme.outlineVariant),
                              ),
                              child: SingleChildScrollView(
                                padding: const EdgeInsets.all(16),
                                child: _TafsirComparisonCardContent(item: item),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    } else {
                      // Stacked Layout for Mobile Screens
                      return ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: items.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(color: colorScheme.outlineVariant),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: _TafsirComparisonCardContent(item: items[index]),
                            ),
                          );
                        },
                      );
                    }
                  },
                );
              },
            ),
          ),

          // Footer Navigation Bar (Ayah Navigation)
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
                  OutlinedButton(
                    onPressed: _currentAyah > 1 ? () => _navigateAyah(-1, maxAyahs) : null,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.chevron_left, size: 18),
                        Text('Prev', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: InkWell(
                      onTap: _openJumpDialog,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: colorScheme.primary.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.unfold_more, size: 14, color: colorScheme.primary),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                'Ayah $_currentAyah/$maxAyahs',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: colorScheme.primary,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  OutlinedButton(
                    onPressed: _currentAyah < maxAyahs ? () => _navigateAyah(1, maxAyahs) : null,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Next', style: TextStyle(fontSize: 12)),
                        Icon(Icons.chevron_right, size: 18),
                      ],
                    ),
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

class _TafsirComparisonCardContent extends ConsumerStatefulWidget {
  final TafsirComparisonItem item;

  const _TafsirComparisonCardContent({required this.item});

  @override
  ConsumerState<_TafsirComparisonCardContent> createState() => _TafsirComparisonCardContentState();
}

class _TafsirComparisonCardContentState extends ConsumerState<_TafsirComparisonCardContent> {
  bool _isDownloading = false;

  void _downloadDirectly() async {
    setState(() {
      _isDownloading = true;
    });

    final db = ref.read(databaseProvider);
    try {
      await ContentPackDownloadService.downloadAndImportPack(
        db: db,
        packId: widget.item.tafsirId,
        packType: 'tafsir',
        downloadUrl: '',
        totalSizeBytes: 12000000,
        onProgress: (_) {},
      );

      ref.invalidate(downloadedTafsirIdsProvider);
      ref.invalidate(comparisonTafsirsProvider);
      ref.invalidate(availableContentPacksProvider);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${widget.item.meta.name} installed successfully!'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to download: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isDownloading = false;
        });
      }
    }
  }

  void _openPackManager() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const ContentPackManagerScreen(),
      ),
    );
    ref.invalidate(downloadedTafsirIdsProvider);
    ref.invalidate(comparisonTafsirsProvider);
    ref.invalidate(availableContentPacksProvider);
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final colorScheme = Theme.of(context).colorScheme;
    final isArabic = item.meta.language == 'ar';
    final content = item.content;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header: Name & Language Badge
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                item.meta.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: colorScheme.primary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                item.meta.language.toUpperCase(),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          'Author: ${item.meta.author}',
          style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: 8),

        // Case 1: Tafsir pack is NOT downloaded yet
        if (!item.isDownloaded) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.tertiaryContainer.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colorScheme.tertiary.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.cloud_download_outlined, size: 36, color: colorScheme.tertiary),
                const SizedBox(height: 8),
                Text(
                  '${item.meta.name} is not downloaded yet',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: colorScheme.onTertiaryContainer,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'Download this classical commentary pack to compare it alongside other Tafsirs offline.',
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onTertiaryContainer.withValues(alpha: 0.8),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                if (_isDownloading) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2.5),
                        ),
                        SizedBox(width: 12),
                        Text('Downloading & installing...', style: TextStyle(fontSize: 13)),
                      ],
                    ),
                  ),
                ] else ...[
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: [
                      FilledButton.icon(
                        onPressed: _downloadDirectly,
                        icon: const Icon(Icons.download, size: 16),
                        label: const Text('Download Now'),
                      ),
                      OutlinedButton(
                        onPressed: _openPackManager,
                        child: const Text('Manage Packs'),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ]
        // Case 2: Downloaded, but no commentary entry for this verse
        else if (content == null) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Icon(Icons.info_outline, size: 28, color: colorScheme.onSurfaceVariant),
                const SizedBox(height: 8),
                Text(
                  'No commentary recorded for this verse in ${item.meta.name}.',
                  style: TextStyle(
                    fontSize: 13,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ]
        // Case 3: Commentary present!
        else ...[
          if (content.startAyah != content.endAyah) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: colorScheme.secondary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Range Commentary: Ayahs ${content.startAyah}–${content.endAyah}',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.secondary,
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
          Divider(height: 16, color: colorScheme.outlineVariant),
          Text(
            content.textContent,
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            style: TextStyle(
              fontSize: isArabic ? 17 : 14.5,
              height: 1.65,
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ],
    );
  }
}
