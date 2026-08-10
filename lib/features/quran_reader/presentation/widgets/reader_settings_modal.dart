import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/reader_preferences.dart';
import '../../providers/reader_providers.dart';

class ReaderSettingsModal extends ConsumerWidget {
  const ReaderSettingsModal({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => const ReaderSettingsModal(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(readerPreferencesProvider);
    final notifier = ref.read(readerPreferencesProvider.notifier);

    return Container(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 30),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Row(
                    children: [
                      Icon(Icons.tune, color: Color(0xFF0F5132)),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Display & Reader Settings',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

            // 1. Reading Mode Selector
            const Text('Reading Mode', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SegmentedButton<ReadingMode>(
              segments: const [
                ButtonSegment(
                  value: ReadingMode.verseByVerse,
                  label: Text('Verse-by-Verse'),
                  icon: Icon(Icons.view_headline),
                ),
                ButtonSegment(
                  value: ReadingMode.continuousScroll,
                  label: Text('Continuous Mushaf'),
                  icon: Icon(Icons.auto_stories),
                ),
              ],
              selected: {prefs.readingMode},
              onSelectionChanged: (selected) {
                notifier.updateReadingMode(selected.first);
              },
            ),
            const SizedBox(height: 16),

            // 2. Tajweed Coloring Toggle
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Tajweed Color-Coding'),
              subtitle: const Text('Highlights Ghunnah, Qalqalah, Madd, Ikhfa rules'),
              value: prefs.showTajweedColoring,
              onChanged: (_) => notifier.toggleTajweedColoring(),
            ),

            // 3. Translation Visibility Toggle
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Show Translation'),
              subtitle: const Text('Display English / installed translation text'),
              value: prefs.showTranslation,
              onChanged: (_) => notifier.toggleTranslation(),
            ),

            const SizedBox(height: 12),

            // 4. Arabic Font Size Slider
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Arabic Font Size', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('${prefs.arabicFontSize.toInt()} pt', style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            Slider(
              min: 18.0,
              max: 42.0,
              divisions: 12,
              value: prefs.arabicFontSize,
              onChanged: (val) => notifier.updateArabicFontSize(val),
            ),

            // 5. Translation Font Size Slider
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Translation Font Size', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('${prefs.translationFontSize.toInt()} pt', style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            Slider(
              min: 12.0,
              max: 24.0,
              divisions: 12,
              value: prefs.translationFontSize,
              onChanged: (val) => notifier.updateTranslationFontSize(val),
            ),

            const SizedBox(height: 8),

            // 6. Font Family Selector
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Arabic Font Style', style: TextStyle(fontWeight: FontWeight.bold)),
                DropdownButton<String>(
                  value: prefs.selectedArabicFont,
                  items: const [
                    DropdownMenuItem(value: 'Amiri', child: Text('Amiri Uthmani')),
                    DropdownMenuItem(value: 'ScheherazadeNew', child: Text('Scheherazade New')),
                  ],
                  onChanged: (val) {
                    if (val != null) notifier.updateArabicFont(val);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
