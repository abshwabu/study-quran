import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('About & Data Attribution'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // App Header Card
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colorScheme.primaryContainer.withValues(alpha: 0.7),
                  colorScheme.secondaryContainer.withValues(alpha: 0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: colorScheme.outlineVariant),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.auto_stories, size: 36, color: colorScheme.onPrimary),
                ),
                const SizedBox(height: 14),
                Text(
                  'StudyQuran Research App',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Version 1.0.0 • Offline-First Quranic Research Engine',
                  style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          Text(
            'Data Sources & Attributions',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: colorScheme.primary),
          ),
          const SizedBox(height: 12),

          _buildSourceTile(
            context: context,
            title: 'Quran Arabic Text & Metadata',
            provider: 'Tanzil.net & King Fahd Complex',
            license: 'Public Domain / Free for academic and research redistribution with attribution.',
            icon: Icons.menu_book,
          ),
          _buildSourceTile(
            context: context,
            title: 'English Translation (Saheeh International)',
            provider: 'Quran.com / Tanzil.net',
            license: 'Public redistribution permitted with attribution.',
            icon: Icons.g_translate,
          ),
          _buildSourceTile(
            context: context,
            title: 'Classical Tafsir Libraries',
            provider: 'Tafsir Al-Muyassar, Jalalayn, Ibn Kathir, Tabari (altafsir.com / Quran.com)',
            license: 'Public domain classical works & academic research permissions.',
            icon: Icons.library_books,
          ),
          _buildSourceTile(
            context: context,
            title: 'Word-by-Word Morphology Corpus',
            provider: 'Quranic Arabic Corpus (University of Leeds)',
            license: 'Creative Commons Attribution-NonCommercial 3.0 Unported (CC BY-NC 3.0).',
            icon: Icons.text_snippet,
          ),
          _buildSourceTile(
            context: context,
            title: 'Audio Recitations',
            provider: 'EveryAyah.com (Mishary Rashid Alafasy, AbdulBaset, Husary)',
            license: 'Permissive audio attribution / EveryAyah open database.',
            icon: Icons.graphic_eq,
          ),

          const Divider(height: 32),
          Center(
            child: Text(
              'Designed & Built with Flutter • 100% Offline & Open Data',
              style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSourceTile({
    required BuildContext context,
    required String title,
    required String provider,
    required String license,
    required IconData icon,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: colorScheme.primary, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 2),
                  Text(
                    'Source: $provider',
                    style: TextStyle(fontSize: 12, color: colorScheme.primary, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    license,
                    style: TextStyle(fontSize: 11, color: colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
