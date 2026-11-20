import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'features/quran_reader/providers/reader_providers.dart';
import 'features/quran_reader/presentation/quran_reader_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: QuranResearchApp(),
    ),
  );
}

class QuranResearchApp extends ConsumerWidget {
  const QuranResearchApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(readerPreferencesProvider.select((p) => p.themeMode));

    return MaterialApp(
      title: 'StudyQuran',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const QuranReaderScreen(),
    );
  }
}
