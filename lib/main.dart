import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/quran_reader/presentation/quran_reader_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: QuranResearchApp(),
    ),
  );
}

class QuranResearchApp extends StatelessWidget {
  const QuranResearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quran Research App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F5132),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const QuranReaderScreen(),
    );
  }
}
