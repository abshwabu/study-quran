import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/providers.dart';
import '../providers/workspace_providers.dart';
import '../domain/citation_export_service.dart';
import '../domain/workspace_backup_service.dart';
import '../../quran_reader/presentation/quran_reader_screen.dart';

class WorkspaceScreen extends ConsumerStatefulWidget {
  const WorkspaceScreen({super.key});

  @override
  ConsumerState<WorkspaceScreen> createState() => _WorkspaceScreenState();
}

class _WorkspaceScreenState extends ConsumerState<WorkspaceScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _notesSearchController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _notesSearchController = TextEditingController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _notesSearchController.dispose();
    super.dispose();
  }

  void _exportCollectionCitations(BuildContext context) async {
    final bookmarks = await ref.read(workspaceDaoProvider).getBookmarks();
    final notes = await ref.read(workspaceDaoProvider).getNotes();

    if (bookmarks.isEmpty) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No bookmarks available to export.')),
      );
      return;
    }

    final exportedText = CitationExportService.formatBatchCitation(
      title: 'All Bookmarked Verses & Notes',
      bookmarks: bookmarks,
      notes: notes,
    );

    await Clipboard.setData(ClipboardData(text: exportedText));
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Batch citation formatted and copied to clipboard!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showBackupRestoreDialog(BuildContext context) {
    final jsonController = TextEditingController();
    final colorScheme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Local Backup & Restore'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Export your entire workspace (bookmarks, notes, collections) as a JSON file or import a backup.',
                style: TextStyle(fontSize: 13, color: colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () async {
                  final db = ref.read(databaseProvider);
                  final jsonString = await WorkspaceBackupService.exportToJson(db);
                  await Clipboard.setData(ClipboardData(text: jsonString));
                  if (!ctx.mounted) return;
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Workspace JSON copied to clipboard!'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.download),
                label: const Text('Export Workspace JSON'),
              ),
              const Divider(height: 24),
              TextField(
                controller: jsonController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Paste backup JSON string here to restore...',
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () async {
                  if (jsonController.text.trim().isEmpty) return;
                  try {
                    final db = ref.read(databaseProvider);
                    await WorkspaceBackupService.importFromJson(db, jsonController.text.trim());
                    ref.invalidate(bookmarksProvider);
                    ref.invalidate(notesProvider);
                    ref.invalidate(collectionsProvider);
                    if (!ctx.mounted) return;
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Workspace restored successfully!'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  } catch (e) {
                    if (!ctx.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to import JSON: $e'),
                        backgroundColor: colorScheme.error,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.upload),
                label: const Text('Import / Restore JSON'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCreateCollectionDialog(BuildContext context) {
    final nameController = TextEditingController();
    final descController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Create New Collection'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Collection Name (e.g. Verses on Patience)'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description (optional)'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.trim().isEmpty) return;
              final colId = 'col_${DateTime.now().millisecondsSinceEpoch}';
              await ref.read(workspaceDaoProvider).createCollection(
                    collectionId: colId,
                    name: nameController.text.trim(),
                    description: descController.text.trim(),
                  );
              ref.invalidate(collectionsProvider);
              if (!ctx.mounted) return;
              Navigator.pop(ctx);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bookmarksAsync = ref.watch(bookmarksProvider);
    final notesAsync = ref.watch(notesProvider);
    final collectionsAsync = ref.watch(collectionsProvider);
    final selectedCollection = ref.watch(selectedCollectionFilterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Research Workspace'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: 'Export Batch Citations',
            onPressed: () => _exportCollectionCitations(context),
          ),
          IconButton(
            icon: const Icon(Icons.cloud_sync),
            tooltip: 'Backup / Restore JSON',
            onPressed: () => _showBackupRestoreDialog(context),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: colorScheme.primary,
          labelColor: colorScheme.primary,
          unselectedLabelColor: colorScheme.onSurfaceVariant,
          tabs: const [
            Tab(icon: Icon(Icons.bookmark), text: 'Bookmarks'),
            Tab(icon: Icon(Icons.note_alt), text: 'Notes'),
            Tab(icon: Icon(Icons.folder), text: 'Collections'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // 1. Bookmarks Tab
          Column(
            children: [
              if (selectedCollection != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer.withValues(alpha: 0.6),
                    border: Border(bottom: BorderSide(color: colorScheme.outlineVariant)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Filtered by Collection',
                        style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.primary),
                      ),
                      TextButton(
                        onPressed: () => ref.read(selectedCollectionFilterProvider.notifier).state = null,
                        child: const Text('Clear Filter'),
                      ),
                    ],
                  ),
                ),
              ],
              Expanded(
                child: bookmarksAsync.when(
                  loading: () => Center(child: CircularProgressIndicator(color: colorScheme.primary)),
                  error: (err, stack) => Center(child: Text('Error: $err')),
                  data: (bookmarks) {
                    if (bookmarks.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.bookmark_border, size: 48, color: colorScheme.onSurfaceVariant),
                              const SizedBox(height: 12),
                              const Text('No bookmarks added yet.', style: TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(
                                'Bookmark verses while reading to organize your research.',
                                style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      itemCount: bookmarks.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final item = bookmarks[index];

                        return Card(
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${item.surahNameTranslit} (${item.bookmark.surahNumber}:${item.bookmark.ayahNumber})',
                                  style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.primary),
                                ),
                                if (item.collection != null)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: colorScheme.secondary.withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      item.collection!.name,
                                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: colorScheme.secondary),
                                    ),
                                  ),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 6),
                                Text(
                                  item.arabicTextUthmani,
                                  textAlign: TextAlign.right,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    fontFamily: 'Uthmani',
                                    fontSize: 18,
                                    color: colorScheme.onSurface,
                                  ),
                                ),
                                if (item.translationText != null) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    item.translationText!,
                                    style: TextStyle(fontSize: 13, color: colorScheme.onSurfaceVariant),
                                  ),
                                ],
                              ],
                            ),
                            trailing: PopupMenuButton<String>(
                              onSelected: (val) async {
                                if (val == 'delete') {
                                  await ref.read(workspaceDaoProvider).removeBookmark(item.bookmark.surahNumber, item.bookmark.ayahNumber);
                                  ref.invalidate(bookmarksProvider);
                                } else if (val == 'cite') {
                                  final citation = CitationExportService.formatSingleCitation(
                                    surahNameTranslit: item.surahNameTranslit,
                                    surahNumber: item.bookmark.surahNumber,
                                    ayahNumber: item.bookmark.ayahNumber,
                                    arabicTextUthmani: item.arabicTextUthmani,
                                    translationText: item.translationText,
                                  );
                                  await Clipboard.setData(ClipboardData(text: citation));
                                  if (!context.mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Citation copied to clipboard!'),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                }
                              },
                              itemBuilder: (ctx) => const [
                                PopupMenuItem(value: 'cite', child: Text('Copy Citation')),
                                PopupMenuItem(value: 'delete', child: Text('Delete Bookmark')),
                              ],
                            ),
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (ctx) => const QuranReaderScreen(),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),

          // 2. Notes Tab
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _notesSearchController,
                  decoration: const InputDecoration(
                    hintText: 'Search personal research notes...',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (val) {
                    ref.read(notesQueryProvider.notifier).state = val.trim();
                  },
                ),
              ),
              Expanded(
                child: notesAsync.when(
                  loading: () => Center(child: CircularProgressIndicator(color: colorScheme.primary)),
                  error: (err, stack) => Center(child: Text('Error: $err')),
                  data: (notes) {
                    if (notes.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Text(
                            'No research notes found.',
                            style: TextStyle(color: colorScheme.onSurfaceVariant),
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: notes.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final item = notes[index];

                        return Card(
                          child: ListTile(
                            title: Text(
                              '${item.surahNameTranslit} (${item.note.surahNumber}:${item.note.startAyah})',
                              style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.primary),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 6),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: colorScheme.outlineVariant),
                                  ),
                                  child: Text(
                                    item.note.textContent,
                                    style: TextStyle(fontSize: 14, color: colorScheme.onSurface, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete_outline, color: colorScheme.error),
                              onPressed: () async {
                                await ref.read(workspaceDaoProvider).deleteNote(item.note.noteId);
                                ref.invalidate(notesProvider);
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),

          // 3. Collections Tab
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _showCreateCollectionDialog(context),
                    icon: const Icon(Icons.create_new_folder),
                    label: const Text('Create New Collection Folder'),
                  ),
                ),
              ),
              Expanded(
                child: collectionsAsync.when(
                  loading: () => Center(child: CircularProgressIndicator(color: colorScheme.primary)),
                  error: (err, stack) => Center(child: Text('Error: $err')),
                  data: (collections) {
                    if (collections.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Text(
                            'No research collections created yet.',
                            style: TextStyle(color: colorScheme.onSurfaceVariant),
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: collections.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final col = collections[index];

                        return Card(
                          child: ListTile(
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(Icons.folder, color: colorScheme.primary, size: 22),
                            ),
                            title: Text(col.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text(
                              col.description.isNotEmpty ? col.description : 'User Research Collection',
                              style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 12),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete_outline, color: colorScheme.error),
                              onPressed: () async {
                                await ref.read(workspaceDaoProvider).deleteCollection(col.collectionId);
                                ref.invalidate(collectionsProvider);
                              },
                            ),
                            onTap: () {
                              ref.read(selectedCollectionFilterProvider.notifier).state = col.collectionId;
                              _tabController.animateTo(0); // Switch to Bookmarks tab
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
