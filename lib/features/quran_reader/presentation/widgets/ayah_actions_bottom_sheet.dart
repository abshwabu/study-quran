import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studyquran/core/database/daos/quran_dao.dart';
import 'package:studyquran/core/database/app_database.dart';
import 'package:studyquran/core/database/providers.dart';
import '../../../tafsir/presentation/single_tafsir_screen.dart';
import '../../../tafsir/presentation/tafsir_comparison_screen.dart';
import '../../../thematic/presentation/widgets/cross_references_bottom_sheet.dart';
import '../../../thematic/presentation/widgets/asbab_al_nuzul_bottom_sheet.dart';
import '../../../workspace/providers/workspace_providers.dart';

class AyahActionsBottomSheet extends ConsumerWidget {
  final AyahWithTranslation ayahData;
  final Surah surahMeta;

  const AyahActionsBottomSheet({
    super.key,
    required this.ayahData,
    required this.surahMeta,
  });

  static void show(BuildContext context, {required AyahWithTranslation ayahData, required Surah surahMeta}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => AyahActionsBottomSheet(ayahData: ayahData, surahMeta: surahMeta),
    );
  }

  void _copyAyahToClipboard(BuildContext context) {
    final String textToCopy = '''
${ayahData.ayah.arabicTextUthmani}

"${ayahData.translationText ?? ''}"
— Surah ${surahMeta.nameTranslit} (${ayahData.ayah.surahNumber}:${ayahData.ayah.ayahNumber})
'''.trim();

    Clipboard.setData(ClipboardData(text: textToCopy));
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied Surah ${surahMeta.nameTranslit} (${ayahData.ayah.surahNumber}:${ayahData.ayah.ayahNumber}) to clipboard!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showBookmarkAndNoteDialog(BuildContext context, WidgetRef ref) {
    final noteController = TextEditingController();
    final dao = ref.read(workspaceDaoProvider);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Bookmark & Research Note (${ayahData.ayah.surahNumber}:${ayahData.ayah.ayahNumber})'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
                onPressed: () async {
                  await dao.addBookmark(
                    surahNumber: ayahData.ayah.surahNumber,
                    ayahNumber: ayahData.ayah.ayahNumber,
                  );
                  ref.invalidate(bookmarksProvider);
                  if (!ctx.mounted) return;
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ayah bookmarked to Research Workspace!')),
                  );
                },
                icon: const Icon(Icons.bookmark_add),
                label: const Text('Add 1-Tap Bookmark'),
              ),
              const Divider(height: 24),
              const Text('Add Personal Research Note', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextField(
                controller: noteController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Write research insights, commentary notes, or reflection...',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              if (noteController.text.trim().isEmpty) return;
              final noteId = 'note_${ayahData.ayah.surahNumber}_${ayahData.ayah.ayahNumber}_${DateTime.now().millisecondsSinceEpoch}';
              await dao.saveNote(
                noteId: noteId,
                surahNumber: ayahData.ayah.surahNumber,
                startAyah: ayahData.ayah.ayahNumber,
                endAyah: ayahData.ayah.ayahNumber,
                textContent: noteController.text.trim(),
              );
              ref.invalidate(notesProvider);
              if (!ctx.mounted) return;
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Research note saved!')),
              );
            },
            child: const Text('Save Note'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Surah ${surahMeta.nameTranslit} • Ayah ${ayahData.ayah.ayahNumber}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 8),

              // 1. Copy Action
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFE8F5E9),
                  child: Icon(Icons.copy, color: Color(0xFF2E7D32)),
                ),
                title: const Text('Copy Ayah & Translation'),
                subtitle: const Text('Copies Arabic text, translation, and reference'),
                onTap: () => _copyAyahToClipboard(context),
              ),

              // 2. View Tafsir Action (Single Tafsir View)
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.purple.shade50,
                  child: Icon(Icons.menu_book, color: Colors.purple.shade700),
                ),
                title: const Text('View Tafsir Commentary'),
                subtitle: const Text('Read classical Tafsir for this ayah offline'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => SingleTafsirScreen(
                        surahNumber: ayahData.ayah.surahNumber,
                        ayahNumber: ayahData.ayah.ayahNumber,
                      ),
                    ),
                  );
                },
              ),

              // 3. Compare Tafsirs Action (Multi-Tafsir Comparison)
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.teal.shade50,
                  child: Icon(Icons.compare_arrows, color: Colors.teal.shade700),
                ),
                title: const Text('Compare Multiple Tafsirs'),
                subtitle: const Text('View 2+ Tafsirs side-by-side or stacked'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => TafsirComparisonScreen(
                        surahNumber: ayahData.ayah.surahNumber,
                        ayahNumber: ayahData.ayah.ayahNumber,
                      ),
                    ),
                  );
                },
              ),

              // 4. Cross References & Related Verses
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.indigo.shade50,
                  child: Icon(Icons.link, color: Colors.indigo.shade700),
                ),
                title: const Text('Related Verses & Cross-References'),
                subtitle: const Text('Thematic links, parallel phrasing, and abrogation notes'),
                onTap: () {
                  Navigator.pop(context);
                  CrossReferencesBottomSheet.show(
                    context,
                    surahNumber: ayahData.ayah.surahNumber,
                    ayahNumber: ayahData.ayah.ayahNumber,
                  );
                },
              ),

              // 5. Asbab al-Nuzul (Occasion of Revelation)
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.amber.shade50,
                  child: Icon(Icons.history_edu, color: Colors.amber.shade800),
                ),
                title: const Text('Asbab al-Nuzul (Revelation Context)'),
                subtitle: const Text('Historical occasion of revelation attributed by scholars'),
                onTap: () {
                  Navigator.pop(context);
                  AsbabAlNuzulBottomSheet.show(
                    context,
                    surahNumber: ayahData.ayah.surahNumber,
                    ayahNumber: ayahData.ayah.ayahNumber,
                  );
                },
              ),

              // 6. Bookmark / Add Research Note
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.orange.shade50,
                  child: Icon(Icons.bookmark_add, color: Colors.orange.shade800),
                ),
                title: const Text('Bookmark / Add Research Note'),
                subtitle: const Text('Save to Workspace collections & write research notes'),
                onTap: () {
                  Navigator.pop(context);
                  _showBookmarkAndNoteDialog(context, ref);
                },
              ),

              // 7. Play Audio Action (Hook for Prompt 09)
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue.shade50,
                  child: Icon(Icons.play_arrow, color: Colors.blue.shade700),
                ),
                title: const Text('Play Recitation'),
                subtitle: const Text('Offline Audio Recitation (Prompt 09 hook)'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Audio recitation feature will be wired in Prompt 09'),
                      duration: Duration(seconds: 2),
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
