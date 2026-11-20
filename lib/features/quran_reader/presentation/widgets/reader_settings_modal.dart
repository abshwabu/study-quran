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
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => const ReaderSettingsModal(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(readerPreferencesProvider);
    final notifier = ref.read(readerPreferencesProvider.notifier);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.only(top: 8, left: 20, right: 20, bottom: 32),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.tune, color: colorScheme.primary),
                    const SizedBox(width: 10),
                    Text(
                      'Display & Reader Settings',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 12),

            // 1. Theme Switcher Section
            Text(
              'Theme & Appearance',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: colorScheme.primary),
            ),
            const SizedBox(height: 8),
            SegmentedButton<ThemeMode>(
              segments: const [
                ButtonSegment(
                  value: ThemeMode.system,
                  label: Text('Auto'),
                  icon: Icon(Icons.brightness_auto, size: 18),
                ),
                ButtonSegment(
                  value: ThemeMode.light,
                  label: Text('Light'),
                  icon: Icon(Icons.light_mode, size: 18),
                ),
                ButtonSegment(
                  value: ThemeMode.dark,
                  label: Text('Dark'),
                  icon: Icon(Icons.dark_mode, size: 18),
                ),
              ],
              selected: {prefs.themeMode},
              onSelectionChanged: (selected) {
                notifier.updateThemeMode(selected.first);
              },
            ),
            const SizedBox(height: 16),

            // 2. Reading Mode Selector
            Text(
              'Reading View Mode',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: colorScheme.primary),
            ),
            const SizedBox(height: 8),
            SegmentedButton<ReadingMode>(
              segments: const [
                ButtonSegment(
                  value: ReadingMode.verseByVerse,
                  label: Text('Verse'),
                  icon: Icon(Icons.view_headline, size: 18),
                ),
                ButtonSegment(
                  value: ReadingMode.continuousScroll,
                  label: Text('Mushaf'),
                  icon: Icon(Icons.menu_book, size: 18),
                ),
                ButtonSegment(
                  value: ReadingMode.wordByWord,
                  label: Text('Word'),
                  icon: Icon(Icons.grid_view, size: 18),
                ),
              ],
              selected: {prefs.readingMode},
              onSelectionChanged: (selected) {
                notifier.updateReadingMode(selected.first);
              },
            ),
            const SizedBox(height: 16),

            // 3. Tajweed Coloring Toggle
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Tajweed Color-Coding', style: TextStyle(fontWeight: FontWeight.w600)),
              subtitle: const Text('Highlights Ghunnah, Qalqalah, Madd, and Ikhfa rules'),
              value: prefs.showTajweedColoring,
              onChanged: (_) => notifier.toggleTajweedColoring(),
            ),

            if (prefs.showTajweedColoring) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: colorScheme.outlineVariant),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(radius: 5, backgroundColor: Color(0xFF2196F3)),
                        SizedBox(width: 6),
                        Text('Madd', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(radius: 5, backgroundColor: Color(0xFF4CAF50)),
                        SizedBox(width: 6),
                        Text('Ghunnah', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(radius: 5, backgroundColor: Color(0xFFFF9800)),
                        SizedBox(width: 6),
                        Text('Qalqalah', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(radius: 5, backgroundColor: Color(0xFFAB47BC)),
                        SizedBox(width: 6),
                        Text('Ikhfa', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],

            // 4. Translation Visibility Toggle
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Show Translation', style: TextStyle(fontWeight: FontWeight.w600)),
              subtitle: const Text('Display English and installed translation commentary'),
              value: prefs.showTranslation,
              onChanged: (_) => notifier.toggleTranslation(),
            ),

            const SizedBox(height: 12),

            // 5. Arabic Font Size Slider
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Arabic Font Size', style: TextStyle(fontWeight: FontWeight.w600)),
                Text(
                  '${prefs.arabicFontSize.toInt()} pt',
                  style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.primary),
                ),
              ],
            ),
            Slider(
              min: 18.0,
              max: 42.0,
              divisions: 12,
              value: prefs.arabicFontSize,
              onChanged: (val) => notifier.updateArabicFontSize(val),
            ),

            // 6. Translation Font Size Slider
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Translation Font Size', style: TextStyle(fontWeight: FontWeight.w600)),
                Text(
                  '${prefs.translationFontSize.toInt()} pt',
                  style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.primary),
                ),
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

            // 7. Font Family Selector
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Arabic Font Style', style: TextStyle(fontWeight: FontWeight.w600)),
                DropdownButton<String>(
                  value: prefs.selectedArabicFont,
                  borderRadius: BorderRadius.circular(12),
                  underline: const SizedBox(),
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
