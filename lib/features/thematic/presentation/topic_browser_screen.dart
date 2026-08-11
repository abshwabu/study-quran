import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/thematic_providers.dart';
import 'topic_detail_screen.dart';

class TopicBrowserScreen extends ConsumerStatefulWidget {
  const TopicBrowserScreen({super.key});

  @override
  ConsumerState<TopicBrowserScreen> createState() => _TopicBrowserScreenState();
}

class _TopicBrowserScreenState extends ConsumerState<TopicBrowserScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: ref.read(topicSearchQueryProvider));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(topicSearchQueryProvider);
    final topicsAsync = ref.watch(searchedTopicsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quranic Thematic Index'),
      ),
      body: Column(
        children: [
          // Search Input
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search topic (e.g. Prayer, Mercy, Creed)...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          ref.read(topicSearchQueryProvider.notifier).state = '';
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (val) {
                ref.read(topicSearchQueryProvider.notifier).state = val.trim();
              },
            ),
          ),

          // Main Tree List or Filtered List
          Expanded(
            child: topicsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error loading topics: $err')),
              data: (topics) {
                if (topics.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Text('No topics found matching your query.'),
                    ),
                  );
                }

                if (query.isNotEmpty) {
                  // Flat list when searching
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: topics.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final topic = topics[index];
                      return Card(
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Color(0xFFE8F5E9),
                            child: Icon(Icons.category, color: Color(0xFF2E7D32)),
                          ),
                          title: Text(topic.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('Category: ${topic.category}'),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => TopicDetailScreen(topic: topic),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                }

                // Hierarchical Expandable Tree when no search query
                final rootTopics = topics.where((t) => t.parentTopicId == null).toList();

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: rootTopics.length,
                  itemBuilder: (context, index) {
                    final parent = rootTopics[index];
                    final children = topics.where((t) => t.parentTopicId == parent.topicId).toList();

                    if (children.isEmpty) {
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: const Icon(Icons.folder_special, color: Colors.teal),
                          title: Text(parent.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(parent.category),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => TopicDetailScreen(topic: parent),
                              ),
                            );
                          },
                        ),
                      );
                    }

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ExpansionTile(
                        leading: const Icon(Icons.folder, color: Colors.teal),
                        title: Text(parent.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        subtitle: Text('${children.length} subtopics'),
                        children: children.map((child) {
                          return ListTile(
                            contentPadding: const EdgeInsets.only(left: 32, right: 16),
                            leading: const Icon(Icons.subdirectory_arrow_right, size: 18, color: Colors.teal),
                            title: Text(child.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => TopicDetailScreen(topic: child),
                                ),
                              );
                            },
                          );
                        }).toList(),
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
