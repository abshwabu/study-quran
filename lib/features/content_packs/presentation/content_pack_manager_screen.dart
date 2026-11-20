import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/providers.dart';
import '../../../core/content_packs/models/pack_manifest.dart';
import '../../../core/content_packs/services/content_pack_download_service.dart';

class ContentPackManagerScreen extends ConsumerStatefulWidget {
  const ContentPackManagerScreen({super.key});

  @override
  ConsumerState<ContentPackManagerScreen> createState() => _ContentPackManagerScreenState();
}

class _ContentPackManagerScreenState extends ConsumerState<ContentPackManagerScreen> {
  bool _wifiOnly = true;
  final Map<String, double> _downloadProgress = {};
  final Map<String, String> _downloadStatus = {};

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  void _loadPreferences() async {
    final wifi = await ContentPackDownloadService.isWifiOnlyEnabled();
    setState(() {
      _wifiOnly = wifi;
    });
  }

  void _triggerDownload(PackManifestItem pack) async {
    final db = ref.read(databaseProvider);

    setState(() {
      _downloadProgress[pack.packId] = 0.05;
      _downloadStatus[pack.packId] = 'Starting...';
    });

    try {
      await ContentPackDownloadService.downloadAndImportPack(
        db: db,
        packId: pack.packId,
        packType: pack.type,
        downloadUrl: pack.downloadUrl,
        totalSizeBytes: pack.sizeBytes,
        onProgress: (prog) {
          setState(() {
            _downloadProgress[pack.packId] = prog.progress;
            _downloadStatus[pack.packId] = prog.statusMessage;
          });
        },
      );

      ref.invalidate(availableContentPacksProvider);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to download ${pack.name}: $e'),
          backgroundColor: Theme.of(context).colorScheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      setState(() {
        _downloadProgress.remove(pack.packId);
        _downloadStatus.remove(pack.packId);
      });
    }
  }

  void _deletePack(PackManifestItem pack) async {
    final db = ref.read(databaseProvider);
    await ContentPackDownloadService.deletePack(db: db, packId: pack.packId);
    ref.invalidate(availableContentPacksProvider);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Removed ${pack.name} from local storage.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  String _formatBytes(int bytes) {
    if (bytes >= 1000000000) {
      return '${(bytes / 1000000000).toStringAsFixed(1)} GB';
    } else if (bytes >= 1000000) {
      return '${(bytes / 1000000).toStringAsFixed(1)} MB';
    } else {
      return '${(bytes / 1000).toStringAsFixed(0)} KB';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final packsAsync = ref.watch(availableContentPacksProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Content Pack Downloader'),
      ),
      body: packsAsync.when(
        loading: () => Center(child: CircularProgressIndicator(color: colorScheme.primary)),
        error: (err, stack) => Center(child: Text('Error loading packs: $err')),
        data: (packs) {
          final totalDownloadedBytes = packs.where((p) => p.isDownloaded).fold<int>(0, (sum, p) => sum + p.sizeBytes);

          return Column(
            children: [
              // Storage Usage & Network Preference Header Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer.withValues(alpha: 0.5),
                  border: Border(bottom: BorderSide(color: colorScheme.outlineVariant)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Local Storage Used',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: colorScheme.onPrimaryContainer),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${_formatBytes(totalDownloadedBytes)} used by installed content packs',
                              style: TextStyle(fontSize: 13, color: colorScheme.onSurfaceVariant),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.sd_storage, size: 24, color: colorScheme.onPrimary),
                        ),
                      ],
                    ),
                    Divider(height: 24, color: colorScheme.outlineVariant),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Wi-Fi Only Downloads', style: TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: const Text('Prevent large downloads over mobile data'),
                      value: _wifiOnly,
                      onChanged: (val) async {
                        await ContentPackDownloadService.setWifiOnlyEnabled(val);
                        setState(() {
                          _wifiOnly = val;
                        });
                      },
                    ),
                  ],
                ),
              ),

              // Content Pack List
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: packs.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final pack = packs[index];
                    final isDownloading = _downloadProgress.containsKey(pack.packId);
                    final progress = _downloadProgress[pack.packId] ?? 0.0;
                    final status = _downloadStatus[pack.packId] ?? '';

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        pack.name,
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        '${pack.type.toUpperCase()} • ${_formatBytes(pack.sizeBytes)}',
                                        style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
                                      ),
                                    ],
                                  ),
                                ),
                                if (pack.isDownloaded) ...[
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: colorScheme.primary.withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.check_circle, color: colorScheme.primary, size: 14),
                                        const SizedBox(width: 4),
                                        Text(
                                          'Installed',
                                          style: TextStyle(color: colorScheme.primary, fontWeight: FontWeight.bold, fontSize: 11),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete_outline, color: colorScheme.error),
                                    onPressed: () => _deletePack(pack),
                                  ),
                                ] else if (isDownloading) ...[
                                  SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(value: progress, strokeWidth: 3, color: colorScheme.primary),
                                  ),
                                ] else ...[
                                  ElevatedButton.icon(
                                    onPressed: () => _triggerDownload(pack),
                                    icon: const Icon(Icons.download, size: 16),
                                    label: const Text('Download'),
                                  ),
                                ],
                              ],
                            ),
                            if (isDownloading) ...[
                              const SizedBox(height: 10),
                              LinearProgressIndicator(value: progress, color: colorScheme.primary),
                              const SizedBox(height: 4),
                              Text(
                                status,
                                style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic, color: colorScheme.primary),
                              ),
                            ],
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
