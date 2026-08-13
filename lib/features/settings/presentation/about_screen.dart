import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About & Data Attribution'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // App Header Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              children: [
                Icon(Icons.auto_stories, size: 48, color: Colors.teal),
                SizedBox(height: 12),
                Text(
                  'StudyQuran Research App',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text('Version 1.0.0 • Offline-First Quranic Research Engine'),
              ],
            ),
          ),
          const SizedBox(height: 24),

          const Text(
            'Data Sources & Attributions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
          ),
          const SizedBox(height: 12),

          _buildSourceTile(
            title: 'Quran Arabic Text & Metadata',
            provider: 'Tanzil.net & King Fahd Complex',
            license: 'Public Domain / Free for academic and research redistribution with attribution.',
            icon: Icons.menu_book,
          ),
          _buildSourceTile(
            title: 'English Translation (Saheeh International)',
            provider: 'Quran.com / Tanzil.net',
            license: 'Public redistribution permitted with attribution.',
            icon: Icons.g_translate,
          ),
          _buildSourceTile(
            title: 'Classical Tafsir Libraries',
            provider: 'Tafsir Al-Muyassar, Jalalayn, Ibn Kathir, Tabari (altafsir.com / Quran.com)',
            license: 'Public domain classical works & academic research permissions.',
            icon: Icons.library_books,
          ),
          _buildSourceTile(
            title: 'Word-by-Word Morphology Corpus',
            provider: 'Quranic Arabic Corpus (University of Leeds)',
            license: 'Creative Commons Attribution-NonCommercial 3.0 Unported (CC BY-NC 3.0).',
            icon: Icons.text_snippet,
          ),
          _buildSourceTile(
            title: 'Audio Recitations',
            provider: 'EveryAyah.com (Mishary Rashid Alafasy, AbdulBaset, Husary)',
            license: 'Permissive audio attribution / EveryAyah open database.',
            icon: Icons.graphic_eq,
          ),

          const Divider(height: 32),
          const Center(
            child: Text(
              'Designed & Built with Flutter • 100% Offline & Open Data',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSourceTile({
    required String title,
    required String provider,
    required String license,
    required IconData icon,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.teal.shade50,
              child: Icon(icon, color: Colors.teal),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 2),
                  Text('Source: $provider', style: const TextStyle(fontSize: 13, color: Colors.teal, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 6),
                  Text('License Note: $license', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
