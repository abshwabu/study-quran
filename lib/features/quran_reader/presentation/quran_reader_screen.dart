import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/providers.dart';

/// Temporary Debug/Verification Screen for Prompt 01 Foundation Verification.
/// UI will be enhanced into full Quran Reader experience in Prompt 02.
class QuranReaderScreen extends ConsumerStatefulWidget {
  const QuranReaderScreen({super.key});

  @override
  ConsumerState<QuranReaderScreen> createState() => _QuranReaderScreenState();
}

class _QuranReaderScreenState extends ConsumerState<QuranReaderScreen> {
  final TextEditingController _searchController = TextEditingController(text: 'Merciful');
  String _activeSearchQuery = 'Merciful';
  int _selectedSurahNumber = 1;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final surahsAsync = ref.watch(surahsProvider);
    final ayahsAsync = ref.watch(surahDetailProvider(_selectedSurahNumber));
    final searchResultsAsync = ref.watch(translationSearchProvider(_activeSearchQuery));
    final packsAsync = ref.watch(availableContentPacksProvider);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Quran Research App — Prompt 01 Debug'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.book), text: 'Surah 1 Reader'),
              Tab(icon: Icon(Icons.search), text: 'FTS5 Search'),
              Tab(icon: Icon(Icons.extension), text: 'Content Packs'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // --- Tab 1: Surah 1 Reader Test ---
            surahsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error loading surahs: $err')),
              data: (surahsList) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      color: Colors.teal.shade50,
                      child: Row(
                        children: [
                          const Text('Select Surah: ', style: TextStyle(fontWeight: FontWeight.bold)),
                          DropdownButton<int>(
                            value: _selectedSurahNumber,
                            items: surahsList.map((s) {
                              return DropdownMenuItem<int>(
                                value: s.number,
                                child: Text('${s.number}. ${s.nameTranslit} (${s.nameArabic})'),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) {
                                setState(() {
                                  _selectedSurahNumber = val;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ayahsAsync.when(
                        loading: () => const Center(child: CircularProgressIndicator()),
                        error: (err, stack) => Center(child: Text('Error loading ayahs: $err')),
                        data: (ayahsList) {
                          if (ayahsList.isEmpty) {
                            return const Center(child: Text('No ayahs found.'));
                          }
                          return ListView.separated(
                            padding: const EdgeInsets.all(16),
                            itemCount: ayahsList.length,
                            separatorBuilder: (_, __) => const Divider(),
                            itemBuilder: (context, index) {
                              final item = ayahsList[index];
                              return Card(
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Chip(label: Text('Verse ${item.ayah.surahNumber}:${item.ayah.ayahNumber}')),
                                          Text('Juz ${item.ayah.juz} • Page ${item.ayah.page}',
                                              style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        item.ayah.arabicTextUthmani,
                                        textAlign: TextAlign.right,
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontFamily: 'Amiri',
                                          height: 1.8,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        item.translationText ?? 'No translation available',
                                        style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),

            // --- Tab 2: FTS5 Full-Text Search Test ---
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: const InputDecoration(
                            labelText: 'FTS5 Translation Search Query',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _activeSearchQuery = _searchController.text;
                          });
                        },
                        child: const Text('Search'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: searchResultsAsync.when(
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (err, stack) => Center(child: Text('Search Error: $err')),
                      data: (results) {
                        if (results.isEmpty) {
                          return const Center(child: Text('No FTS5 search matches found.'));
                        }
                        return ListView.builder(
                          itemCount: results.length,
                          itemBuilder: (context, index) {
                            final res = results[index];
                            return ListTile(
                              leading: CircleAvatar(child: Text('${res.surahNumber}:${res.ayahNumber}')),
                              title: Text('Surah ${res.surahNumber}, Ayah ${res.ayahNumber}'),
                              subtitle: Text(res.textSnippet),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // --- Tab 3: Content Pack Repository Test ---
            packsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error loading packs: $err')),
              data: (packs) {
                if (packs.isEmpty) {
                  return const Center(child: Text('No content packs found in manifest.'));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: packs.length,
                  itemBuilder: (context, index) {
                    final pack = packs[index];
                    final isDefaultBundled = pack.packId == 'en.saheeh';
                    return Card(
                      child: ListTile(
                        leading: Icon(
                          pack.type == 'translation'
                              ? Icons.translate
                              : pack.type == 'tafsir'
                                  ? Icons.menu_book
                                  : pack.type == 'audio'
                                      ? Icons.audiotrack
                                      : Icons.account_tree,
                          color: Colors.teal,
                        ),
                        title: Text(pack.name),
                        subtitle: Text('Type: ${pack.type} • Version: ${pack.version}\nLicense: ${pack.licenseNote}'),
                        trailing: Chip(
                          backgroundColor: isDefaultBundled ? Colors.green.shade100 : Colors.grey.shade200,
                          label: Text(
                            isDefaultBundled ? 'Downloaded' : 'Available',
                            style: TextStyle(
                              color: isDefaultBundled ? Colors.green.shade800 : Colors.black87,

                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// PROMPT HOOKS FOR FUTURE BUILD STEPS:
// Prompt 02: Replace QuranReaderScreen debug layout with smooth infinite reader, tajweed colorizer, translation toggle
// Prompt 03: Inject Tafsir comparison side-by-side view into Ayah card
// Prompt 04: Connect SearchDao to advanced root-word search interface
// Prompt 05: Render interactive Word-by-Word morphology popups on word tap
// Prompt 06: Hook Asbab al-Nuzul and Thematic Index navigation
// Prompt 07: Add Bookmark/Note action buttons per Ayah
// Prompt 08: Integrate Gemini AI Assistant drawer & prompt generator
// Prompt 09: Complete background download manager in ContentPackRepository for data packs
