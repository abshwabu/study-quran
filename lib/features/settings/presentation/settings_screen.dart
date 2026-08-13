import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/providers.dart';
import '../../quran_reader/domain/reader_preferences.dart';
import '../../quran_reader/providers/reader_providers.dart';
import '../../ai_assistant/providers/ai_providers.dart';
import '../../ai_assistant/presentation/ai_settings_screen.dart';
import '../../content_packs/presentation/content_pack_manager_screen.dart';
import '../domain/full_backup_service.dart';
import 'about_screen.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

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
            children: [
              const Text(
                'Paste your full backup JSON string below to restore workspace data and settings.',
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: jsonController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Paste backup JSON string here...',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
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
                                child: Text('• $packId', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal)),
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
                    SnackBar(content: Text(result.message)),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(result.message), backgroundColor: Colors.red),
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(readerPreferencesProvider);
    final prefsNotifier = ref.watch(readerPreferencesProvider.notifier);
    final keyState = ref.watch(apiKeyProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings & Preferences'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 1. Reading Preferences Section
          const Text('Reading Preferences', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.teal)),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                ListTile(
                  title: const Text('Arabic Font Size'),
                  subtitle: Slider(
                    value: prefs.arabicFontSize,
                    min: 16.0,
                    max: 36.0,
                    divisions: 10,
                    label: '${prefs.arabicFontSize.round()} pt',
                    onChanged: (val) => prefsNotifier.updateArabicFontSize(val),
                  ),
                ),
                ListTile(
                  title: const Text('Translation Font Size'),
                  subtitle: Slider(
                    value: prefs.translationFontSize,
                    min: 12.0,
                    max: 24.0,
                    divisions: 6,
                    label: '${prefs.translationFontSize.round()} pt',
                    onChanged: (val) => prefsNotifier.updateTranslationFontSize(val),
                  ),
                ),
                SwitchListTile(
                  title: const Text('Color Tajweed Highlights'),
                  subtitle: const Text('Highlight Madd, Ghunnah, and Ikhfa rules'),
                  value: prefs.showTajweedColoring,
                  onChanged: (val) => prefsNotifier.toggleTajweedColoring(),
                ),

              ],
            ),
          ),
          const SizedBox(height: 16),

          // 2. AI Research Assistant Section
          const Text('AI Research Assistant (Gemini)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.teal)),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.auto_awesome, color: Colors.blue),
              title: const Text('Gemini Model: gemini-3.5-flash-lite'),
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

          // 3. Content Packs & Downloads
          const Text('Content Packs & Storage', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.teal)),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.download, color: Colors.orange),
              title: const Text('Content Pack Downloader'),
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

          // 4. Full Backup & Restore Section
          const Text('Backup & Restore', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.teal)),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.download_for_offline, color: Colors.teal),
                  title: const Text('Export Full App Backup JSON'),
                  subtitle: const Text('Backup workspace entries, settings, and pack manifest'),
                  onTap: () => _exportFullBackup(context, ref),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.upload_file, color: Colors.teal),
                  title: const Text('Restore Full App Backup JSON'),
                  subtitle: const Text('Restore workspace data & app preferences from backup'),
                  onTap: () => _showRestoreDialog(context, ref),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // 5. About & Attribution Section
          const Text('App Information', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.teal)),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.info_outline, color: Colors.teal),
              title: const Text('About & Data Sources Attribution'),
              subtitle: const Text('View open licenses for Quran text, translations, tafsirs & morphology'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const AboutScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
