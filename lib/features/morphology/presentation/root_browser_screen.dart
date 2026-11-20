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
    final colorScheme = Theme.of(context).colorScheme;
    final rootsAsync = ref.watch(rootsListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quranic Arabic Root Browser'),
      ),
      body: Column(
        children: [
          // Search Input
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search root (Arabic e.g. كتب or translit kataba)...',
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
              ),
              onChanged: (val) {
                ref.read(rootBrowserQueryProvider.notifier).state = val.trim();
              },
            ),
          ),

          // Roots List View
          Expanded(
            child: rootsAsync.when(
              loading: () => Center(child: CircularProgressIndicator(color: colorScheme.primary)),
              error: (err, stack) => Center(child: Text('Error loading roots: $err')),
              data: (roots) {
                if (roots.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 48, color: colorScheme.onSurfaceVariant),
                          const SizedBox(height: 12),
                          Text(
                            'No roots found matching search.',
                            style: TextStyle(color: colorScheme.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: roots.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final root = roots[index];

                    return Card(
                      child: ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            root.rootTranslit.split('-').first.toUpperCase(),
                            style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.primary),
                          ),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${root.rootArabic} (${root.rootTranslit})',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: colorScheme.secondary.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                '${root.occurrenceCount}x',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: colorScheme.secondary),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            root.meaningsSummary.isNotEmpty ? root.meaningsSummary : 'Primary Semitic Root',
                            style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 13),
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
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
