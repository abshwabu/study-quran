import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/providers.dart';
import '../../../core/database/daos/workspace_dao.dart';
import '../../../core/database/app_database.dart';

final collectionsProvider = FutureProvider<List<WorkspaceCollection>>((ref) async {
  final dao = ref.watch(workspaceDaoProvider);
  return dao.getAllCollections();
});

final selectedCollectionFilterProvider = StateProvider<String?>((ref) => null);

final bookmarksProvider = FutureProvider<List<BookmarkWithAyah>>((ref) async {
  final colId = ref.watch(selectedCollectionFilterProvider);
  final dao = ref.watch(workspaceDaoProvider);
  return dao.getBookmarks(collectionId: colId);
});

final notesQueryProvider = StateProvider<String>((ref) => '');

final notesProvider = FutureProvider<List<NoteWithAyah>>((ref) async {
  final query = ref.watch(notesQueryProvider);
  final dao = ref.watch(workspaceDaoProvider);
  return dao.getNotes(searchQuery: query);
});

final tagsProvider = FutureProvider<List<WorkspaceTag>>((ref) async {
  final dao = ref.watch(workspaceDaoProvider);
  return dao.getAllTags();
});

final isBookmarkedProvider = FutureProvider.family<bool, ({int surahNumber, int ayahNumber})>((ref, arg) async {
  final dao = ref.watch(workspaceDaoProvider);
  return dao.isAyahBookmarked(arg.surahNumber, arg.ayahNumber);
});
