import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/morphology_providers.dart';
import '../../search/presentation/root_concordance_screen.dart';

class RootBrowserScreen extends ConsumerStatefulWidget {
  const RootBrowserScreen({super.key});

  @override
  ConsumerState<RootBrowserScreen> createState() => _RootBrowserScreenState();
}

class _RootBrowserScreenState extends ConsumerState<RootBrowserScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: ref.read(rootBrowserQueryProvider));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rootsAsync = ref.watch(rootsListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quranic Root Index'),
      ),
      body: Column(
        children: [
          // Search Input Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search root (e.g. r-h-m or ر ح م)...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          ref.read(rootBrowserQueryProvider.notifier).state = '';
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (val) {
                ref.read(rootBrowserQueryProvider.notifier).state = val.trim();
              },
            ),
          ),

          // Roots List View
          Expanded(
            child: rootsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error loading roots: $err')),
              data: (roots) {
                if (roots.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 48, color: Colors.grey),
                          SizedBox(height: 12),
                          Text('No roots found matching search.'),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: roots.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final root = roots[index];

                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.teal.shade50,
                          child: Text(
                            root.rootTranslit.split('-').first.toUpperCase(),
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal.shade800),
                          ),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${root.rootArabic} (${root.rootTranslit})',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Chip(
                              visualDensity: VisualDensity.compact,
                              backgroundColor: Colors.amber.shade50,
                              label: Text(
                                '${root.occurrenceCount}x',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.amber.shade900),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            root.meaningsSummary.isNotEmpty ? root.meaningsSummary : 'Quranic root index entry',
                            style: const TextStyle(color: Colors.black87),
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => RootConcordanceScreen(rootArabic: root.rootArabic),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
