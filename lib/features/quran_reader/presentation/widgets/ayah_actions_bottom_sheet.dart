import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studyquran/core/database/daos/quran_dao.dart';
import 'package:studyquran/core/database/app_database.dart';

class AyahActionsBottomSheet extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Surah ${surahMeta.nameTranslit} • Ayah ${ayahData.ayah.ayahNumber}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 8),

          // 1. Copy Action (Fully Built)
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Color(0xFFE8F5E9),
              child: Icon(Icons.copy, color: Color(0xFF2E7D32)),
            ),
            title: const Text('Copy Ayah & Translation'),
            subtitle: const Text('Copies Arabic text, translation, and reference'),
            onTap: () => _copyAyahToClipboard(context),
          ),

          // 2. Play Audio Action (Hook for Prompt 09)
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

          // 3. View Tafsir Action (Hook for Prompt 03)
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.purple.shade50,
              child: Icon(Icons.menu_book, color: Colors.purple.shade700),
            ),
            title: const Text('View Tafsir'),
            subtitle: const Text('Tafsir Library & Comparison (Prompt 03 hook)'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Tafsir comparison view will be wired in Prompt 03'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),

          // 4. Bookmark & Notes Action (Hook for Prompt 07)
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.amber.shade50,
              child: Icon(Icons.bookmark_border, color: Colors.amber.shade800),
            ),
            title: const Text('Bookmark / Add Note'),
            subtitle: const Text('Research Workspace & Tags (Prompt 07 hook)'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Bookmarks & Research notes will be wired in Prompt 07'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
