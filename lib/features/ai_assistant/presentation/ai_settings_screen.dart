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
    final keyState = ref.watch(apiKeyProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Research Assistant Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Information Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.auto_awesome, color: Colors.blue.shade800),
                      const SizedBox(width: 8),
                      Text(
                        'Gemini AI Key Setup',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue.shade900),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Provide your personal Google Gemini API key to enable AI-assisted verse explanations, tafsir comparisons, and workspace summaries.',
                    style: TextStyle(fontSize: 13, height: 1.4),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '🔒 Security Guarantee: Your key is stored ONLY locally on device in system secure storage (Keystore/Keychain). It is never sent to any server except directly to Google API endpoints.',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black87),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            keyState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
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
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                          onPressed: () => setState(() => _obscureText = !_obscureText),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
                            onPressed: () async {
                              final key = _keyController.text.trim();
                              if (key.isNotEmpty) {
                                await ref.read(apiKeyProvider.notifier).setKey(key);
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('API Key saved securely!')),
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
                          color: _testSuccess ? Colors.green.shade50 : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: _testSuccess ? Colors.green.shade300 : Colors.red.shade300),
                        ),
                        child: Row(
                          children: [
                            Icon(_testSuccess ? Icons.check_circle : Icons.error, color: _testSuccess ? Colors.green : Colors.red),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                _testMessage!,
                                style: TextStyle(color: _testSuccess ? Colors.green.shade900 : Colors.red.shade900, fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    if (hasKey) ...[
                      const Divider(height: 32),
                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(foregroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
                        onPressed: () async {
                          await ref.read(apiKeyProvider.notifier).clearKey();
                          await ref.read(aiHistoryDaoProvider).clearAiHistory();
                          _keyController.clear();
                          setState(() {
                            _testMessage = null;
                          });
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('API key and local AI history cleared!')),
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
