import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/providers.dart';
import '../../quran_reader/providers/reader_providers.dart';
import '../../ai_assistant/providers/ai_providers.dart';
import '../../ai_assistant/presentation/ai_settings_screen.dart';
import '../../content_packs/presentation/content_pack_manager_screen.dart';
import '../domain/full_backup_service.dart';
import 'about_screen.dart';

final themeModeProvider = Provider<ThemeMode>((ref) {
  return ref.watch(readerPreferencesProvider.select((p) => p.themeMode));
});

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  void _exportFullBackup(BuildContext context, WidgetRef ref) async {
    final db = ref.read(databaseProvider);
    final jsonString = await FullBackupService.exportFullBackup(db);
    await Clipboard.setData(ClipboardData(text: jsonString));
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Full app backup (Workspace + Settings) copied to clipboard!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showRestoreDialog(BuildContext context, WidgetRef ref) {
    final jsonController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Restore Full App Backup'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Paste your full backup JSON string below to restore workspace data and settings.',
                style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: jsonController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Paste backup JSON string here...',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton.icon(
            onPressed: () async {
              if (jsonController.text.trim().isEmpty) return;
              final db = ref.read(databaseProvider);
              final result = await FullBackupService.restoreFullBackup(db, jsonController.text.trim());

              if (!ctx.mounted) return;
              Navigator.pop(ctx);

              if (result.success) {
                if (result.missingContentPacks.isNotEmpty) {
                  showDialog(
                    context: context,
                    builder: (missingCtx) => AlertDialog(
                      title: const Text('Content Packs Required'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('The following content packs were in use on your previous setup and need to be re-downloaded:'),
                          const SizedBox(height: 12),
                          ...result.missingContentPacks.map((packId) => Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Text('• $packId', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
                              )),
                        ],
                      ),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(missingCtx), child: const Text('Later')),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(missingCtx);
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (c) => const ContentPackManagerScreen()),
                            );
                          },
                          child: const Text('Open Downloader'),
                        ),
                      ],
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(result.message), behavior: SnackBarBehavior.floating),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(result.message),
                    backgroundColor: Theme.of(context).colorScheme.error,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            icon: const Icon(Icons.upload),
            label: const Text('Restore Backup'),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, IconData icon) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: colorScheme.primary),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: colorScheme.primary,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final prefs = ref.watch(readerPreferencesProvider);
    final prefsNotifier = ref.watch(readerPreferencesProvider.notifier);
    final keyState = ref.watch(apiKeyProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings & Preferences'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          // 1. Appearance & Theme Switcher Section
          _buildSectionHeader(context, 'Appearance & Theme', Icons.palette_outlined),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose App Theme',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Select light, dark, or automatic system appearance',
                    style: TextStyle(
                      fontSize: 12,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _ThemeOptionCard(
                          title: 'System',
                          icon: Icons.brightness_auto,
                          isSelected: prefs.themeMode == ThemeMode.system,
                          onTap: () => prefsNotifier.updateThemeMode(ThemeMode.system),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _ThemeOptionCard(
                          title: 'Light',
                          icon: Icons.light_mode,
                          isSelected: prefs.themeMode == ThemeMode.light,
                          onTap: () => prefsNotifier.updateThemeMode(ThemeMode.light),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _ThemeOptionCard(
                          title: 'Dark',
                          icon: Icons.dark_mode,
                          isSelected: prefs.themeMode == ThemeMode.dark,
                          onTap: () => prefsNotifier.updateThemeMode(ThemeMode.dark),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 2. Reading Preferences Section
          _buildSectionHeader(context, 'Reading Typography & Tajweed', Icons.menu_book_outlined),
          Card(
            child: Column(
              children: [
                ListTile(
                  title: const Text('Arabic Font Size', style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Slider(
                    value: prefs.arabicFontSize,
                    min: 16.0,
                    max: 36.0,
                    divisions: 10,
                    label: '${prefs.arabicFontSize.round()} pt',
                    onChanged: (val) => prefsNotifier.updateArabicFontSize(val),
                  ),
                  trailing: Text(
                    '${prefs.arabicFontSize.round()} pt',
                    style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.primary),
                  ),
                ),
                const Divider(indent: 16, endIndent: 16),
                ListTile(
                  title: const Text('Translation Font Size', style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Slider(
                    value: prefs.translationFontSize,
                    min: 12.0,
                    max: 24.0,
                    divisions: 6,
                    label: '${prefs.translationFontSize.round()} pt',
                    onChanged: (val) => prefsNotifier.updateTranslationFontSize(val),
                  ),
                  trailing: Text(
                    '${prefs.translationFontSize.round()} pt',
                    style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.primary),
                  ),
                ),
                const Divider(indent: 16, endIndent: 16),
                SwitchListTile(
                  title: const Text('Color Tajweed Highlights', style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: const Text('Highlight Madd, Ghunnah, and Ikhfa pronunciation rules'),
                  value: prefs.showTajweedColoring,
                  onChanged: (val) => prefsNotifier.toggleTajweedColoring(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // 3. AI Research Assistant Section
          _buildSectionHeader(context, 'AI Research Assistant', Icons.auto_awesome),
          Card(
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.auto_awesome, color: Colors.blue, size: 22),
              ),
              title: const Text('Gemini Assistant (gemini-3.5-flash-lite)', style: TextStyle(fontWeight: FontWeight.w600)),
              subtitle: keyState.when(
                loading: () => const Text('Checking API key...'),
                error: (e, s) => const Text('Error loading key'),
                data: (key) => Text(key != null && key.isNotEmpty ? 'Status: Active Key Configured' : 'Status: No API Key Set'),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const AiSettingsScreen()),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // 4. Content Packs & Downloads
          _buildSectionHeader(context, 'Content Packs & Storage', Icons.cloud_download_outlined),
          Card(
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorScheme.secondary.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.download, color: colorScheme.secondary, size: 22),
              ),
              title: const Text('Content Pack Downloader', style: TextStyle(fontWeight: FontWeight.w600)),
              subtitle: const Text('Manage translations, tafsirs, morphology & audio reciters'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const ContentPackManagerScreen()),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // 5. Full Backup & Restore Section
          _buildSectionHeader(context, 'Backup & Restore', Icons.backup_outlined),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.download_for_offline, color: colorScheme.primary, size: 22),
                  ),
                  title: const Text('Export Full App Backup JSON', style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: const Text('Backup workspace entries, settings, and pack manifest'),
                  onTap: () => _exportFullBackup(context, ref),
                ),
                const Divider(indent: 16, endIndent: 16),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.upload_file, color: colorScheme.primary, size: 22),
                  ),
                  title: const Text('Restore Full App Backup JSON', style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: const Text('Restore workspace data & app preferences from backup'),
                  onTap: () => _showRestoreDialog(context, ref),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // 6. About & Attribution Section
          _buildSectionHeader(context, 'App Information', Icons.info_outline),
          Card(
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.info_outline, color: colorScheme.primary, size: 22),
              ),
              title: const Text('About & Data Sources Attribution', style: TextStyle(fontWeight: FontWeight.w600)),
              subtitle: const Text('View open licenses for Quran text, translations, tafsirs & morphology'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const AboutScreen()),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _ThemeOptionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOptionCard({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primaryContainer.withValues(alpha: 0.6) : colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? colorScheme.primary : colorScheme.outlineVariant,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 26,
              color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? colorScheme.primary : colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
