import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/ai_providers.dart';
import '../domain/gemini_api_service.dart';
import '../../../core/database/providers.dart';

class AiSettingsScreen extends ConsumerStatefulWidget {
  const AiSettingsScreen({super.key});

  @override
  ConsumerState<AiSettingsScreen> createState() => _AiSettingsScreenState();
}

class _AiSettingsScreenState extends ConsumerState<AiSettingsScreen> {
  late TextEditingController _keyController;
  bool _obscureText = true;
  bool _isTesting = false;
  String? _testMessage;
  bool _testSuccess = false;

  @override
  void initState() {
    super.initState();
    _keyController = TextEditingController();
  }

  @override
  void dispose() {
    _keyController.dispose();
    super.dispose();
  }

  Future<void> _testKey() async {
    final key = _keyController.text.trim();
    if (key.isEmpty) {
      setState(() {
        _testSuccess = false;
        _testMessage = 'Please enter an API key to test.';
      });
      return;
    }

    setState(() {
      _isTesting = true;
      _testMessage = null;
    });

    try {
      final ok = await GeminiApiService.testConnection(key);
      if (ok) {
        setState(() {
          _testSuccess = true;
          _testMessage = 'Success! Gemini API Key is valid and working.';
        });
      }
    } catch (e) {
      setState(() {
        _testSuccess = false;
        _testMessage = e.toString();
      });
    } finally {
      setState(() {
        _isTesting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final keyState = ref.watch(apiKeyProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Research Assistant Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Information Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.auto_awesome, color: Colors.blue),
                      SizedBox(width: 8),
                      Text(
                        'Gemini AI Key Setup',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Provide your personal Google Gemini API key to enable AI-assisted verse explanations, tafsir comparisons, and workspace summaries.',
                    style: TextStyle(fontSize: 13, height: 1.4, color: colorScheme.onSurface),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '🔒 Security Guarantee: Your key is stored ONLY locally on device in system secure storage (Keystore/Keychain). It is never sent to any server except directly to Google API endpoints.',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            keyState.when(
              loading: () => Center(child: CircularProgressIndicator(color: colorScheme.primary)),
              error: (err, stack) => Text('Error loading key: $err'),
              data: (existingKey) {
                if (_keyController.text.isEmpty && existingKey != null) {
                  _keyController.text = existingKey;
                }

                final hasKey = existingKey != null && existingKey.isNotEmpty;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: _keyController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        labelText: 'Gemini API Key',
                        hintText: 'AIzaSy...',
                        suffixIcon: IconButton(
                          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                          onPressed: () => setState(() => _obscureText = !_obscureText),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              final key = _keyController.text.trim();
                              if (key.isNotEmpty) {
                                await ref.read(apiKeyProvider.notifier).setKey(key);
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('API Key saved securely!'),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              }
                            },
                            icon: const Icon(Icons.save),
                            label: const Text('Save Key'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        OutlinedButton.icon(
                          onPressed: _isTesting ? null : _testKey,
                          icon: _isTesting
                              ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                              : const Icon(Icons.check_circle_outline),
                          label: const Text('Test Key'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    if (_testMessage != null) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _testSuccess
                              ? colorScheme.primaryContainer.withValues(alpha: 0.5)
                              : colorScheme.errorContainer.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: _testSuccess ? colorScheme.primary : colorScheme.error,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              _testSuccess ? Icons.check_circle : Icons.error,
                              color: _testSuccess ? colorScheme.primary : colorScheme.error,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                _testMessage!,
                                style: TextStyle(
                                  color: _testSuccess ? colorScheme.primary : colorScheme.error,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    if (hasKey) ...[
                      Divider(height: 32, color: colorScheme.outlineVariant),
                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: colorScheme.error,
                          side: BorderSide(color: colorScheme.error),
                        ),
                        onPressed: () async {
                          await ref.read(apiKeyProvider.notifier).clearKey();
                          await ref.read(aiHistoryDaoProvider).clearAiHistory();
                          _keyController.clear();
                          setState(() {
                            _testMessage = null;
                          });
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('API key and local AI history cleared!'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        icon: const Icon(Icons.delete_forever),
                        label: const Text('Remove API Key & Clear AI History'),
                      ),
                    ],
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
