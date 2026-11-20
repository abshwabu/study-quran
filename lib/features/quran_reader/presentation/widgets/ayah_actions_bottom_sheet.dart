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
import '../../../ai_assistant/presentation/widgets/ai_explain_ayah_modal.dart';
import '../../../audio/domain/audio_player_service.dart';

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
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
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
    final colorScheme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Bookmark & Note (${ayahData.ayah.surahNumber}:${ayahData.ayah.ayahNumber})',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FilledButton.icon(
                onPressed: () async {
                  await dao.addBookmark(
                    surahNumber: ayahData.ayah.surahNumber,
                    ayahNumber: ayahData.ayah.ayahNumber,
                  );
                  ref.invalidate(bookmarksProvider);
                  if (!ctx.mounted) return;
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Ayah bookmarked to Research Workspace!'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.bookmark_add),
                label: const Text('Add 1-Tap Bookmark'),
              ),
              const SizedBox(height: 16),
              Divider(color: colorScheme.outlineVariant),
              const SizedBox(height: 12),
              Text(
                'Add Personal Research Note',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: colorScheme.primary),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: noteController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Write research reflections, cross-reference notes, or questions...',
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
                const SnackBar(
                  content: Text('Research note saved!'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Save Note'),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile({
    required BuildContext context,
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 22),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

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
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${surahMeta.number}:${ayahData.ayah.ayahNumber}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: colorScheme.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Surah ${surahMeta.nameTranslit}',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 6),

              // 1. Copy Action
              _buildActionTile(
                context: context,
                icon: Icons.copy,
                color: colorScheme.primary,
                title: 'Copy Ayah & Translation',
                subtitle: 'Copies Arabic text, translation, and reference to clipboard',
                onTap: () => _copyAyahToClipboard(context),
              ),

              // 2. Play Audio Recitation
              _buildActionTile(
                context: context,
                icon: Icons.play_circle_fill,
                color: colorScheme.secondary,
                title: 'Play Recitation',
                subtitle: 'Play verse audio recitation (Mishary Alafasy)',
                onTap: () {
                  Navigator.pop(context);
                  AudioPlayerService.playAyah(
                    surahNumber: ayahData.ayah.surahNumber,
                    ayahNumber: ayahData.ayah.ayahNumber,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Playing Surah ${surahMeta.nameTranslit} (${ayahData.ayah.surahNumber}:${ayahData.ayah.ayahNumber})...'),
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),

              // 3. View Tafsir Action
              _buildActionTile(
                context: context,
                icon: Icons.menu_book,
                color: const Color(0xFF8E24AA),
                title: 'View Classical Tafsir',
                subtitle: 'Read classical Tafsir commentary offline',
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

              // 4. Compare Tafsirs
              _buildActionTile(
                context: context,
                icon: Icons.compare_arrows,
                color: const Color(0xFF00897B),
                title: 'Compare Multiple Tafsirs',
                subtitle: 'View 2+ Tafsirs side-by-side or stacked',
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

              // 5. Cross References & Related Verses
              _buildActionTile(
                context: context,
                icon: Icons.hub_outlined,
                color: const Color(0xFF3949AB),
                title: 'Related Verses & Cross-References',
                subtitle: 'Thematic links, parallel phrasing, and abrogation notes',
                onTap: () {
                  Navigator.pop(context);
                  CrossReferencesBottomSheet.show(
                    context,
                    surahNumber: ayahData.ayah.surahNumber,
                    ayahNumber: ayahData.ayah.ayahNumber,
                  );
                },
              ),

              // 6. Asbab al-Nuzul (Occasion of Revelation)
              _buildActionTile(
                context: context,
                icon: Icons.history_edu,
                color: const Color(0xFFD81B60),
                title: 'Asbab al-Nuzul (Historical Context)',
                subtitle: 'Historical occasion of revelation attributed by scholars',
                onTap: () {
                  Navigator.pop(context);
                  AsbabAlNuzulBottomSheet.show(
                    context,
                    surahNumber: ayahData.ayah.surahNumber,
                    ayahNumber: ayahData.ayah.ayahNumber,
                  );
                },
              ),

              // 7. AI Explain This Ayah
              _buildActionTile(
                context: context,
                icon: Icons.auto_awesome,
                color: Colors.blue,
                title: 'AI Explain This Ayah',
                subtitle: 'Gemini AI verse analysis & thematic breakdown',
                onTap: () {
                  Navigator.pop(context);
                  AiExplainAyahModal.show(
                    context,
                    surahNameTranslit: surahMeta.nameTranslit,
                    surahNumber: ayahData.ayah.surahNumber,
                    ayahNumber: ayahData.ayah.ayahNumber,
                    arabicTextUthmani: ayahData.ayah.arabicTextUthmani,
                    translationText: ayahData.translationText ?? '',
                  );
                },
              ),

              // 8. Bookmark / Add Research Note
              _buildActionTile(
                context: context,
                icon: Icons.bookmark_add,
                color: const Color(0xFFF57C00),
                title: 'Bookmark / Add Research Note',
                subtitle: 'Save to Workspace collections & write personal study notes',
                onTap: () {
                  Navigator.pop(context);
                  _showBookmarkAndNoteDialog(context, ref);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
