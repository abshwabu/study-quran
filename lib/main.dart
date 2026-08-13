import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'features/quran_reader/presentation/quran_reader_screen.dart';
import 'features/settings/presentation/settings_screen.dart';

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
    final themeMode = ref.watch(themeModeProvider);

    const primaryEmerald = Color(0xFF0F5132); // Rich Emerald
    const secondaryGold = Color(0xFFD4AF37); // Warm Gold

    return MaterialApp(
      title: 'StudyQuran',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryEmerald,
          secondary: secondaryGold,
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.outfitTextTheme(ThemeData.light().textTheme),
        appBarTheme: AppBarTheme(
          elevation: 0,
          scrolledUnderElevation: 2,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          titleTextStyle: GoogleFonts.outfit(
            color: primaryEmerald,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: const IconThemeData(color: primaryEmerald),
        ),
        cardTheme: CardThemeData(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),

      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryEmerald,
          secondary: secondaryGold,
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme),
        appBarTheme: AppBarTheme(
          elevation: 0,
          scrolledUnderElevation: 2,
          backgroundColor: const Color(0xFF121814),
          surfaceTintColor: Colors.transparent,
          titleTextStyle: GoogleFonts.outfit(
            color: const Color(0xFF81C784),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: const IconThemeData(color: Color(0xFF81C784)),
        ),
        cardTheme: CardThemeData(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),

      ),
      home: const QuranReaderScreen(),
    );
  }
}
