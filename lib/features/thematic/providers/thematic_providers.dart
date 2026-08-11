import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/providers.dart';
import '../../../core/database/daos/thematic_dao.dart';
import '../../../core/database/app_database.dart';

final rootTopicsProvider = FutureProvider<List<Topic>>((ref) async {
  final dao = ref.watch(thematicDaoProvider);
  return dao.getRootTopics();
});

final childTopicsProvider = FutureProvider.family<List<Topic>, String>((ref, parentTopicId) async {
  final dao = ref.watch(thematicDaoProvider);
  return dao.getChildTopics(parentTopicId);
});

final topicSearchQueryProvider = StateProvider<String>((ref) => '');

final searchedTopicsProvider = FutureProvider<List<Topic>>((ref) async {
  final query = ref.watch(topicSearchQueryProvider);
  final dao = ref.watch(thematicDaoProvider);
  return dao.searchTopics(query);
});

final topicAyahsProvider = FutureProvider.family<List<TopicAyahResult>, String>((ref, topicId) async {
  final dao = ref.watch(thematicDaoProvider);
  return dao.getAyahsForTopic(topicId);
});

final crossReferencesForAyahProvider = FutureProvider.family<List<CrossReferenceWithAyah>, ({int surahNumber, int ayahNumber})>((ref, arg) async {
  final dao = ref.watch(thematicDaoProvider);
  return dao.getCrossReferencesForAyah(
    surahNumber: arg.surahNumber,
    ayahNumber: arg.ayahNumber,
  );
});

final asbabAlNuzulForAyahProvider = FutureProvider.family<AsbabAlNuzulEntry?, ({int surahNumber, int ayahNumber})>((ref, arg) async {
  final dao = ref.watch(thematicDaoProvider);
  return dao.getAsbabAlNuzulForAyah(
    surahNumber: arg.surahNumber,
    ayahNumber: arg.ayahNumber,
  );
});
