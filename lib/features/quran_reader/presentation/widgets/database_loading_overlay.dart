import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/providers.dart';

class DatabaseLoadingOverlay extends ConsumerWidget {
  const DatabaseLoadingOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final initStatus = ref.watch(databaseInitProvider);
    final notifier = ref.read(databaseInitProvider.notifier);

    final percentage = (initStatus.progress * 100).clamp(0, 100).toInt();

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Header App Icon & Title
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      colorScheme.primaryContainer,
                      colorScheme.secondaryContainer.withValues(alpha: 0.5),
                    ],
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(color: colorScheme.outlineVariant),
                ),
                child: Icon(
                  Icons.auto_stories,
                  size: 52,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Quran Research App',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Offline-First Quran, Tafsir & Concordance',
                style: TextStyle(fontSize: 14, color: colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 36),

              if (initStatus.error != null) ...[
                // Error Display
                Icon(Icons.error_outline, size: 48, color: colorScheme.error),
                const SizedBox(height: 16),
                Text(
                  initStatus.message,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: colorScheme.error, fontSize: 13),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () => notifier.retry(),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry Initializing Database'),
                ),
              ] else ...[
                // Progress Bar & Percentage Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Loading Database', style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
                    Text('$percentage%', style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.primary)),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: initStatus.progress,
                    minHeight: 10,
                    backgroundColor: colorScheme.primaryContainer.withValues(alpha: 0.5),
                    valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
                  ),
                ),
                const SizedBox(height: 16),

                // Detailed Progress Step Message
                Text(
                  initStatus.message,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: colorScheme.onSurfaceVariant),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
